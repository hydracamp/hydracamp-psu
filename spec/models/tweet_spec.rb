require 'spec_helper'

describe Tweet do
   it "should have a zombie" do
       t = Tweet.new(:message=>'another tweet' )
       t.zombie = nil
       t.should_not be_valid
       another_zombie = Zombie.create(:name=>"Ash", :graveyard=>"Duke Memorial")
       another_tweet = Tweet.new(:message=>'another tweet')
       another_tweet.zombie = another_zombie  
    another_tweet.should be_valid
   end

end
