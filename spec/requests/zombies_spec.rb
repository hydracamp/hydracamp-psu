require 'spec_helper'

describe "Zombies" do
  describe "creating" do
    it "should create a zombie" do
      visit new_zombie_path
      fill_in "Name", :with =>'Ash'
      fill_in "Graveyard", :with => 'Creepy Hollow'
      click_button "Create"
      page.should have_content "Added Zombie"
      page.should have_content "Ash"
    end
  end

  describe "viewing" do
    before do
      @ash = Zombie.create(:name=>'Ash', :graveyard=>'Cedarville Cemetary')
      @sarah = Zombie.create(:name=>"Sarah")
    end
    it "should display a list of zombies with links to the show page" do
      visit zombies_path
      page.should have_link "Ash", :href=>zombie_path(@ash)
      click_link 'Ash'
      page.should have_content "Cedarville Cemetary"
    end
  end
end
