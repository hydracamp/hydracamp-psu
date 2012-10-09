require 'spec_helper'

describe "Zombies" do
  describe "indexing" do
     before do
      @ash = Zombie.create(:name=>'Ash', :graveyard=>'Cedarville Cemetary', :nickname=>'Hruuungh')
    end

    it "should have a create new zombie link" do
      visit zombies_path
      page.should have_content("Ash")
      page.should have_content("Hruuungh")
      page.should have_link('Edit', href: edit_zombie_path(@ash))
      page.should have_link('Create New Zombie', href: new_zombie_path)

    end
  end

  describe "creating" do
    it "should create a zombie" do
      visit new_zombie_path
      fill_in "Name", :with =>'Ash'
      fill_in "Graveyard", :with => 'Creepy Hollow'
      fill_in "Nickname", :with => 'Hruuungh'
      click_button "Create"
      page.should have_content "Added Zombie"
      page.should have_content "Ash"
      page.should have_content "(level 1)"
    end
  end

  describe "viewing" do
    before do
      @ash = Zombie.create(:name=>'Ash', :graveyard=>'Cedarville Cemetary', :nickname=>'Hruuungh')
      @sarah = Zombie.create(:name=>"Sarah")
    end
    it "should display a list of zombies with links to the show page" do
      visit zombies_path
      page.should have_link "Ash", :href=>zombie_path(@ash)
      click_link 'Ash'
      page.should have_content "Cedarville Cemetary"
      page.should have_content "level 1"
      page.should have_content "Hruuungh"
    end
  
    it "should show the details for a specific zombie" do
      visit zombies_path
      click_link @ash.name
      
      current_path.should == zombie_path(@ash)
      within "#zombie_details" do
        page.should have_content "Ash"
        page.should have_content "Cedarville Cemetary"
        page.should have_content "Number of Tweets:"
      end
    end
    
    it "should display a link to the homepage" do
      #Given I am on any page
      visit zombie_path(@ash)
      #I should see a link to homepage
      page.should have_link "home", :href=>zombies_path
      visit edit_zombie_path(@ash)
      page.should have_link "home", :href=>zombies_path
    end
  end
  
  describe "showing" do
    before do
      @ash = Zombie.create(:name=>'Ash', :graveyard=>'Cedarville Cemetary', :description=> "The zombie smells bad")
      @ash.tweets.new(:message=>'test tweet 1')
    end
    
    it "should display a description of a zombie" do
      visit zombie_path(@ash)
      page.should have_content "The zombie smells bad"
      page.should have_content "description"
      
    end

    it "should respond to a request for an XML or JSON response" do
      get zombie_path(@ash), {:format=>'xml'}
      assert_response :success
      response.body.should == @ash.to_xml

      get zombie_path(@ash), {:format=>'json'}
      assert_response :success
      response.body.should == @ash.to_json
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
      fill_in "Nickname", :with=>"Hruuungh"

      # When I click "Update Zombie" 
      click_button "Update Zombie"

      # Then it should save the changes 
      page.should have_selector "input[value='David']"
      page.should have_selector "input[value='Cedarville Cemetary']"
      page.should have_selector "input[value='Hruuungh']"

      # And I should see a message that says "page saved at <current time>" 
      page.body.should match /Zombie saved at \d\d:\d\d/
      #page.should have_content "page saved at "

      # And I should see the edit form again
      current_path.should == edit_zombie_path(@zombie)
    end
    it "should have a link to view the zombie" do
      #When I am editing a zombie
      visit edit_zombie_path(@zombie)

      #Then I should see a link to show the zombie
      page.should have_link('View Zombie', href: zombie_path(@zombie))

      #When I click on the link
      click_link "View Zombie"

      #Then I should see the show page for that zombie
      current_path.should == zombie_path(@zombie)
    end

    describe "creator" do
    before do
       @roy = Zombie.create(:name=>'Roy')
       @sarah = Zombie.create(:name=>'Sarah')
    end
      it "should edit the zombie creator" do
         #Given that I am on the edit page for a zombie named "Ash"
         visit edit_zombie_path(@zombie)

         # Then I should be able to edit the zombies creator 
         select 'Sarah', :from => 'Creator'
         click_button "Update Zombie"
page.has_select?('zombie_creator_id', :selected => "Sarah").should == true
#         page.should have_css  'div.creator :option, :value => 'Sarah'
       end
    end
    
  end
end
