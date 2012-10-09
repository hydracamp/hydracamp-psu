class AddDateOfDeathColumnToZombies < ActiveRecord::Migration
  def change
    add_column :zombies, :date_of_death, :date
  end
end
