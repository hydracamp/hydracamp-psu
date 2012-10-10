require 'spec_helper'

describe "Tweets" do
  describe "viewing" do
    before do
      @ash = Zombie.create(:name=>'Ash', :graveyard=>'Cedarville Cemetary', :nickname=>'Hruuungh', :weapon=>'hatchet', :date_of_death=>Date.parse('August 9, 2012'))
      @ash.tweets << Tweet.new(:message => 'uhhhhggg')
      #@tweet = Tweet.create(:zombie => @ash, :message => 'uhhhhggg')
    end

    it "should display a list of tweets with each zombie name linking to the show page" do
      visit tweets_path
      page.should have_link "Ash", :href=>zombie_path(@ash)
    end
  end
end
