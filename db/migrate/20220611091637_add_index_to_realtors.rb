class AddIndexToRealtors < ActiveRecord::Migration[6.0]
  def up
    add_earthdistance_index :realtors
  end

  def down
    remove_earthdistance_index :realtors
  end
end
