class Appointment < ApplicationRecord
  acts_as_geolocated

  belongs_to :realtor
  belongs_to :seller
end
