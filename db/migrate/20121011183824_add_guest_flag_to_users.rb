# -*- encoding : utf-8 -*-
class AddGuestFlagToUsers < ActiveRecord::Migration
  def self.up
    create_table :users
    add_column :users, :guest, :boolean, :default => false
  end

  def self.down
    drop_table :users
  end
end
