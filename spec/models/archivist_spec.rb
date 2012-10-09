require 'spec_helper'

describe Archivist do
  it "should have an email" do
    subject.email = "Reaper"
    subject.email.should == "Reaper"
  end
  
  it "should have a password" do
    subject.password = "reapaz"
    subject.password.should == "reapaz"
  end
  
  it "should validate that the email is present" do
    subject.should_not be_valid
    subject.errors[:email].first.should == "can't be blank"
    subject.email = 'Reaper@graveyard.edu'
    subject.password = 'reapaz'
    subject.should be_valid
  end

  it "should validate that the email is unique" do
    subject.email = 'Reaper@graveyard.edu'
    subject.password = 'reapaz'
    subject.save!

    another_user = Archivist.new(:email=>'Reaper@graveyard.edu')
    another_user.should_not be_valid
    another_user.errors[:email].first.should == "has already been taken"

    another_user.email = "sarah@graveyard.edu"
    another_user.password = 'reapaz'
    another_user.should be_valid
  end
end
