# -*- encoding : utf-8 -*-
class AddGuestFlagToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :guest, :boolean, :default => false
  end

  def self.down
    remove_column :users, :guest, :boolean
  end
end
