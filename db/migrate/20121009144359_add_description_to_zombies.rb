class AddDescriptionToZombies < ActiveRecord::Migration
  def change
    add_column :zombies, :description, :string
  end
end
