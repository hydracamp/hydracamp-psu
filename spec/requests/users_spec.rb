require 'spec_helper'

describe "Users" do

  describe "login" do
    before do
      @ash = User.create(:email=>'Ash@grave.edu', :password=>'ashinthewind')
    end
    it "should log you in" do
      visit new_user_session_path
      fill_in "Email", with: @ash.email
      fill_in "Password", with: "ashinthewind"
      click_button 'Sign in'
      page.should have_content "Welcome #{@ash.email}"
      page.should have_content "Signed in successfully"
    end
  end

  describe "logout" do
    before do
      @ash = User.create(:email=>'Ash@grave.edu', :password=>'ashinthewind')
      visit new_user_session_path
      fill_in "Email", with: @ash.email
      fill_in "Password", with: "ashinthewind"
      click_button 'Sign in'
    end
    it "should log you out" do
      visit zombies_path
      click_button 'logout'
      page.should have_content "Welcome stranger"
      page.should have_content "Signed out successfully"
    end
  end

  describe "signup" do
    it "should log you out" do
      visit new_user_session_path
      click_link 'Sign up'
      fill_in "Email", with: 'Ash@grave.edu'
      fill_in "Password", with: "ashinthewind"
      fill_in "Password confirmation", with: "ashinthewind"
      click_button 'Sign up'

      page.should have_content "Welcome ash@grave.edu"
      page.should have_content "You have signed up successfully"
    end
  end
end
