class AddLevelsForZombies < ActiveRecord::Migration
  def change
    add_column :zombies, :level, :integer, default: 1
  end
end
