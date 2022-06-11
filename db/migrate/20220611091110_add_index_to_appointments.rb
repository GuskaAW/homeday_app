class AddIndexToAppointments < ActiveRecord::Migration[6.0]
  def up
    add_earthdistance_index :appointments
  end

  def down
    remove_earthdistance_index :appointments
  end
end
