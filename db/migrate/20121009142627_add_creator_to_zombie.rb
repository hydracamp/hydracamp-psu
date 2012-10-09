class AddCreatorToZombie < ActiveRecord::Migration
  def change
    add_column :zombies, :creator_id, :integer
  end
end
