class AddSellerToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_reference :appointments, :seller, index: true, foreign_key: true
  end
end
