class AddLevelToZombies < ActiveRecord::Migration
  def change
    add_column :zombies, :level, :integer
  end
end
