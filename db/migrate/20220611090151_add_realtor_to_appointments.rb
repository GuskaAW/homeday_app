class AddRealtorToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_reference :appointments, :realtor, index: true, foreign_key: true
  end
end
