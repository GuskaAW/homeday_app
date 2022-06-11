class Appointment < ApplicationRecord
  belongs_to :realtor
  belongs_to :seller
end
