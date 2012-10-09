class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :zombie
      t.string :message

      t.timestamps
    end
    add_index :tweets, :zombie_id
  end
end
