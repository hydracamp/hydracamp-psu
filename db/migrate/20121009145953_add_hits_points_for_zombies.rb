class AddHitsPointsForZombies < ActiveRecord::Migration
  def change
    add_column :zombies, :hit_points, :integer
  end
end
