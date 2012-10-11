# -*- encoding : utf-8 -*-
class AddGuestFlagToUsers < ActiveRecord::Migration
  def self.up
    add_column :archivists, :guest, :boolean, :default => false
  end

  def self.down
    remove_column :archivists, :guest, :boolean
  end
end
