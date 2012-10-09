class AddRatingToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :rating, :integer, :default => 0
  end
end
