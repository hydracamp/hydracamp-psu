require 'spec_helper'

describe ZombiesController do
  describe "#new" do
    it "should set a template zombie" do
      get :new
      response.should be_successful
      assigns[:zombie].should be_kind_of Zombie
    end
  end

  describe "#create" do
    before do
      @count = Zombie.count
    end
    it "should create a zombie" do
      post :create, :zombie=>{:name=>"Ash", :graveyard=>"Sleepy Hollow"}
      response.should redirect_to zombies_path
      Zombie.count.should == @count + 1
      flash[:notice].should == "Added Zombie"
    end
  end

  describe "#index" do
    before do
      @zombie1 = Zombie.create(:name=>"Ash")
      @zombie2 = Zombie.create(:name=>"Sarah")
    end
    it "should display a list of all the zombies" do
      get :index
      response.should be_successful
      assigns[:zombies].should == [@zombie1, @zombie2]
    end
  end

end
