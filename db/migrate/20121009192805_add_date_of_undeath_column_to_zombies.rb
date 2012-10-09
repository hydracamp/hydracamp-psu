class AddDateOfUndeathColumnToZombies < ActiveRecord::Migration
  def change
    add_column :zombies, :date_of_undeath, :datetime
  end
end
