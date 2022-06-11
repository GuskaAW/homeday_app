class Realtor < ApplicationRecord
  acts_as_geolocated

  has_many :appointments
end
