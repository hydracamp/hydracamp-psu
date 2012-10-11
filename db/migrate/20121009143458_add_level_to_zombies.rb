class AddLevelToZombies < ActiveRecord::Migration
  def change
    add_column :zombies, :level, :integer
    Zombie.update_all ["level = ?", 1]
  end
end
