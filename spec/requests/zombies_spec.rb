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
  
    it "should show the details for a specific zombie" do
      visit zombies_path
      click_link @ash.name
      
      current_path.should == zombie_path(@ash)
      within "#zombie_details" do
        page.should have_content "Ash"
        page.should have_content "Cedarville Cemetary"
      end
    end
  end

  describe "editing" do
    before do
      @zombie = Zombie.create(:name=>"Ash")
    end
    it "should edit the zombie" do
      # Given that I'm on the show page for a zombie named "Ash" 
      visit zombie_path(@zombie)

      # When I click the "edit" button 
      page.should have_link "edit", :href=>edit_zombie_path(@zombie)
      click_link "edit"

      # Then I should be able to edit the zombies name and graveyard 
      fill_in "Name", :with=>"David"
      fill_in "Graveyard", :with=>"Cedarville Cemetary"

      # When I click "Update Zombie" 
      click_button "Update Zombie"

      # Then it should save the changes 
      page.should have_selector "input[value='David']"
      page.should have_selector "input[value='Cedarville Cemetary']"

      # And I should see a message that says "page saved at <current time>" 
      page.body.should match /Zombie saved at \d\d:\d\d/
      #page.should have_content "page saved at "

      # And I should see the edit form again
      current_path.should == edit_zombie_path(@zombie)
    end
  end
end
