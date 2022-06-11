class Appointment < ApplicationRecord
  acts_as_geolocated

  belongs_to :realtor
  belongs_to :seller

  validates :seller_id, presence: true
  validates :realtor_id, presence: true
  validates :address, presence: true
  validates :time, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
end
