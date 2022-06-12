class Appointment < ApplicationRecord
  acts_as_geolocated

  belongs_to :realtor
  belongs_to :seller

  validates :seller_id, presence: true
  validates :realtor_id, presence: true
  # don't need it now, I have new method check_appointment_params
  # validates :address, presence: true
  # validates :time, presence: true
  # validates :lat, presence: true
  # validates :lng, presence: true
end

# do to in the future method for seller for checking params before seller saved
