class AddDeletedAtToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :deleted_at, :datetime
  end
end
