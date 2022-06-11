# frozen_string_literal: true

class SetAppointmentService
  def call(payload)
    seller = Seller.new(name: payload[:appointment][:seller][:name],
                        phone: payload[:appointment][:seller][:phone])

    appointment = Appointment.new(lat: payload[:appointment][:lat],
                                  lng: payload[:appointment][:lng],
                                  address: payload[:appointment][:address],
                                  time: payload[:appointment][:time])
    return missing_input if !check_appointment_params(appointment)

    return error_no_realtor if check_if_weekend(appointment)

    return error_no_realtor if check_not_opening_hours(appointment)

    return error_no_realtor if !good_range_of_days_to_appointment(appointment)

    point = [appointment.lat, appointment.lng]
    # radius in meters 20 000 =  20 km
    # hint: https://rdoc.info/gems/activerecord-postgres-earthdistance/0.7.1
    closest = Realtor.within_radius(20_000, *point).order_by_distance(*point).selecting_distance_from(*point).first
    return error_no_realtor if closest == nil

    seller.save
    appointment.seller = seller
    appointment.realtor = closest
    if appointment.save
      create_response(appointment)
    else
      missing_input
    end
  end

  private

  def check_appointment_params(appointment)
    appointment.attributes.values_at("lat", "lng", "address", "time").all?(&:present?)
  end

  def check_if_weekend(appointment)
    # 0 Sun, 6 Sat
    (appointment.time.wday % 7) == 0 || (appointment.time.wday % 7) == 6
  end

  def check_not_opening_hours(appointment)
    appointment.time.strftime('%H:%M').to_i < 8 || appointment.time.strftime('%H:%M').to_i > 18
  end

  def good_range_of_days_to_appointment(appointment)
    which_day = Time.now.wday % 7

    days_to_ap = (appointment.time.to_date - DateTime.now.to_date).to_i

    if (which_day == 1 || which_day == 2) && days_to_ap >= 3 # >48h in days - 3days
      true
    elsif (which_day == 3 || which_day == 4 || which_day == 5) && days_to_ap >= 5
      true
    elsif which_day == 6 && days_to_ap >= 4
      true
    elsif which_day == 0 && days_to_ap >= 3
      true
    else
      false
    end
    # I don't check if the relator has another appointment because I don't have his calendar
    # I don't set 30 min appointment, because I don't have his calendar
  end

  def error_no_realtor
    { message: "No realtor available", code: 400 }
  end

  def missing_input
    { message: "Missing input values", code: 400 }
  end

  def create_response(appointment)
    {
      lat: appointment.lat,
      lng: appointment.lng,
      address: appointment.address,
      time: appointment.time.strftime("%d/%m/%Y %H:%M"),
      seller: {
        name: appointment.seller.name,
        phone: appointment.seller.phone
      },
      realtor: {
        name: appointment.realtor.name,
        city: appointment.realtor.city
      }
    }
  end
end
