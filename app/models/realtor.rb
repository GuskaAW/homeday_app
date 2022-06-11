class Realtor < ApplicationRecord
  acts_as_geolocated

  has_many :appointments

  validates :name, presence: true
  validates :city, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
end
