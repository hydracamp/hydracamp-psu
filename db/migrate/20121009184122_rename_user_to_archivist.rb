class RenameUserToArchivist < ActiveRecord::Migration
  def up
    rename_table :users, :archivists
  end

  def down
    rename_table :archivists, :users
  end
end
