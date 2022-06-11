class AddLatAndLngToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :appointments, :lng, :decimal, {:precision=>10, :scale=>6}
  end
end
