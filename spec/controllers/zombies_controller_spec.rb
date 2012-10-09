require 'spec_helper'

describe ZombiesController do
  
  render_views
  
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
      post :create, :zombie=>{:name=>"Ash", :graveyard=>"Sleepy Hollow", :nickname=>"Hruuungh"}
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

  describe "#show" do
    before do
      @ash = Zombie.create(:name=>'Ash')
      @tweet1 = @ash.tweets.create(:message => "blah blah blah")
      @tweet2 = @ash.tweets.create(:message => "I brake for brains!")
    end

    it "should be successful" do
      get :show, :id=>@ash
      response.should be_successful
      assigns[:zombie].should == @ash
      assigns[:tweet].should be_kind_of Tweet
    end
    
    it "should be successful" do
      get :show, :id=>@ash
      
    end
    
    it "should display a list of the zombie's tweets" do
      get :show, :id=>@ash
      response.body.should have_selector("span.message", :content => @tweet1.message)
      response.body.should have_selector("span.message", :content => @tweet2.message)
    end
    
    it "should display the timestamp with the tweet message" do
      get :show, :id => @ash
      response.body.should have_selector("span.timestamp", :content => @tweet1.created_at.to_s)
    end
    
  end

  describe "#edit" do
    before do
      @ash = Zombie.create(:name=>'Ash')
    end
    it "should be successful" do
      get :edit, :id=>@ash
      response.should be_successful
      assigns[:zombie].should == @ash
    end
  end

  describe "#update" do
    before do
      @ash = Zombie.create(:name=>"Ash")
    end
    it "should update the zombie" do
      put :update, :id=>@ash, :zombie=> { :name=>"David", :graveyard=>"River's Edge", :nickname=>"Hruuungh"}
      response.should redirect_to edit_zombie_path(@ash)
      @ash.reload.name.should == 'David'
      @ash.graveyard.should == "River's Edge"
      @ash.nickname.should == "Hruuungh"
      flash[:notice].should match /Zombie saved at \d\d:\d\d/
    end

  end

end
