class AddDateOfBirthColumnToZombies < ActiveRecord::Migration
  def change
    add_column :zombies, :date_of_birth, :datetime
  end
end
