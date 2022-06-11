class Seller < ApplicationRecord
  has_many :appointments

  validates :name, presence: true
  validates :phone, presence: true
end
