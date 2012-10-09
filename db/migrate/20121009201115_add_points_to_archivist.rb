class AddPointsToArchivist < ActiveRecord::Migration
  def change
    add_column :archivists, :points, :integer
  end
end
