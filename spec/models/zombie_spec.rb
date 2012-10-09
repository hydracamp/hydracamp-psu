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

  it "should have a date of death" do
    subject.date_of_death = "10/05/2012"
    subject.date_of_death.should == Date.parse("10/05/2012")
  end

  it "should validate that the name is present" do
    subject.should_not be_valid
    subject.errors[:name].first.should == "can't be blank"
    subject.name = 'Ash'
    subject.should be_valid
  end

  it "should validate that the name is unique" do
    subject.name = 'Ash'
    subject.save!
    another_zombie = Zombie.new(:name=>'Ash')
    another_zombie.should_not be_valid
    another_zombie.errors[:name].first.should == "has already been taken"
    another_zombie.name = "Sarah"
    another_zombie.should be_valid
  end
end
