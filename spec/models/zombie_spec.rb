require 'spec_helper'

describe Zombie do

  it 'should have many tweets' do
    subject.tweets.build.should be_instance_of Tweet
  end

  it "should have a name" do
    subject.name = "Ash"
    subject.name.should == "Ash"
  end

  it "should have a graveyard" do
    subject.graveyard = "Creepy Hollow"
    subject.graveyard.should == "Creepy Hollow"
  end
  
  it "should have a description" do
    subject.description = "The zombie smells bad"
    subject.description.should == "The zombie smells bad"
  end
 
  # A new zombie should start with a default number of hit points
  # when created
  it "should have hit points" do
    subject.hit_points.should == 100
  end

  it "should have a default level of 1" do
    subject.level.should == 1
  end

  it "should have a creator" do
    another_zombie = Zombie.create(:name=>"Sarah")
    subject.creator = another_zombie
    subject.creator.should == another_zombie
  end

  it "should have a date of death" do
    subject.date_of_death = "10/05/2012"
    subject.date_of_death.should == Date.parse("10/05/2012")
  end

  it "should have a weapon" do
    subject.weapon = "hatchet"
    subject.weapon.should == "hatchet"
  end

  it "should validate that the weapon is present" do
    subject.should_not be_valid
    subject.errors[:weapon].first.should == "can't be blank"
    subject.weapon = 'axe'
    subject.name = 'Ash'
    subject.should be_valid
  end

  it "should validate that the name is present" do
    subject.should_not be_valid
    subject.errors[:name].first.should == "can't be blank"
    subject.name = 'Ash'
    subject.weapon = 'axe'
    subject.should be_valid
  end
  it "should be level 1" do
    subject.name = 'Ash'
    subject.weapon = 'axe'
    subject.save!
    subject.level.should == 1
  end
  it "should validate that the name is unique" do
    subject.weapon = 'axe'
    subject.name = 'Ash'
    subject.save!
    another_zombie = Zombie.new(:name=>'Ash')
    another_zombie.should_not be_valid
    another_zombie.errors[:name].first.should == "has already been taken"
    another_zombie.name = "Sarah"
    another_zombie.weapon = "hatchet"
    another_zombie.should be_valid
  end

  it "should have a active field with a default value of true" do
    subject.active.should == true
  end

  it "should have a wins field with a defaul value of 0" do
    subject.wins.should == 0
  end
  
  it "should have a losses field with a defaul value of 0" do
    subject.losses.should == 0
  end
end
