class AppointmentsController < ApplicationController
  protect_from_forgery with: :null_session
  def create
    response = SetAppointmentService.new.call(params)
    render json: response, status: response[:code]
  end

  def past
    realtor = Realtor.find(params[:id])
    past_appointments = Array.new
    realtor.appointments.each do |a|
      if a.time < DateTime.now.to_date
        past_appointments << a
      end
    end
    byebug
    render json: past_appointments.sort
  end

  def future
    realtor = Realtor.find(params[:id])
    future_appointments = Array.new
    realtor.appointments.each do |a| 
      if a.time > DateTime.now.to_date
        future_appointments << a
      end
    end
    render json: future_appointments.sort.reverse
  end
end
