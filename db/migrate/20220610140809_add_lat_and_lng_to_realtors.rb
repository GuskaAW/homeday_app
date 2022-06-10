class AddLatAndLngToRealtors < ActiveRecord::Migration[6.0]
  def change
    add_column :realtors, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :realtors, :lng, :decimal, {:precision=>10, :scale=>6}
  end
end
