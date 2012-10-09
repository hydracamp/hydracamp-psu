class AddNicknameToZombies < ActiveRecord::Migration
  def change
    add_column :zombies, :nickname, :string
  end
end
