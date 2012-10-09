class AddAvatarToZombies < ActiveRecord::Migration
  def self.up
    add_attachment :zombies, :avatar
  end

  def self.down
    remove_attachment :zombies, :avatar
  end
end
