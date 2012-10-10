require 'spec_helper'

def logmein
  visit new_archivist_session_path
  @ash = Archivist.create!(:email=>'Ash@grave.edu', :password=>'ashinthewind')
  fill_in "Email", with: @ash.email
  fill_in "Password", with: "ashinthewind"
  click_button 'Sign in'
end

describe "Zombies" do
  describe "indexing" do
     before do
      Zombie.find_each{|z| z.delete}
      @ash = Zombie.create(:name=>'Ash', :graveyard=>'Cedarville Cemetary', :nickname=>'Hruuungh', :weapon => 'axe')
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
    before do
      logmein
    end
    
    it "should create a zombie" do
      visit new_zombie_path
      fill_in "Name", :with =>'Ash'
      fill_in "Graveyard", :with => 'Creepy Hollow'

      fill_in "Nickname", :with => 'Hruuungh'
      select('2012', :from => 'zombie_date_of_death_1i')
      select('October', :from => 'zombie_date_of_death_2i')
      select('9', :from => 'zombie_date_of_death_3i')
      fill_in "Description", :with => 'The zombie smells pretty bad'
      attach_file "Avatar", 'test/fixtures/zombie.jpg'
      fill_in "Weapon", :with => 'Axe'

      click_button "Create Zombie"
      page.should have_content "Added Zombie"
      page.should have_content "Ash"
      page.should have_content "The zombie smells pretty bad"
      #page.should have_content "zombie.jpg"
    # page.should have_content "(level 1)"
    end
  end

  describe "viewing" do
    before do
      Zombie.find_each{|z| z.delete}
      @ash = Zombie.create(:name=>'Ash', :graveyard=>'Cedarville Cemetary', :nickname=>'Hruuungh', :weapon=>'hatchet', :date_of_death=>"8-9-2012")
      @sarah = Zombie.create(:name=>"Sarah", :weapon=>'hatchet')
    end
    it "should display a list of zombies with links to the show page" do
      visit zombies_path
      page.should have_link "Ash", :href=>zombie_path(@ash)
      click_link 'Ash'
      page.should have_content "Cedarville Cemetary"
      page.should have_content "Hruuungh"
      page.should have_content "August 9, 2012"
    end

    it "should show the details for a specific zombie" do
      visit zombies_path

      click_link @ash.name

      current_path.should == zombie_path(@ash)
      within "#zombie_name" do
        page.should have_content "Ash"
      end
      within "#zombie_details" do
        page.should have_content "Cedarville Cemetary"
      end
    end

    it "should display a link to the homepage" do
      #Given I am on any page
      visit zombie_path(@ash)
      #I should see a link to homepage
      page.should have_link "Home", href: zombies_path
      visit edit_zombie_path(@ash)
      page.should have_link "Home", href: zombies_path
    end

    it "should display a link to an instructional video" do
      visit zombie_path(@ash)
      page.should have_link "Instructional Video", :href=>"http://www.youtube.com/watch?v=0UqEhUm2B_8"
    end

    it "should display the zombie's level on the index page" do
      @sarah.level = 2
      @sarah.save

      visit zombies_path
      page.should have_selector "tr[data-zombie='#{@sarah.id}']"

      within "tr[data-zombie='#{@sarah.id}'] td.zombie_level" do
        page.should have_content 2
      end
    end
  end

  describe "showing" do
    before do
      Zombie.find_each{|z| z.delete}
      @ash = Zombie.create(:name=>'Ash', :graveyard=>'Cedarville Cemetary', :description=> "The zombie smells bad", :weapon => 'axe')
      @ash.tweets.new(:message=>'test tweet 1')
    end

    it "should display a description of a zombie" do
      visit zombie_path(@ash)
      page.should have_content "The zombie smells bad"
      page.should have_content "Description"

    end

    it "should respond to a request for an XML or JSON response" do
      get zombie_path(@ash), {:format=>'xml'}
      assert_response :success
      response.body.should == @ash.to_xml

      get zombie_path(@ash), {:format=>'json'}
      assert_response :success
      response.body.should == @ash.to_json
    end

    describe "with tweets" do
      before do
        @t = Tweet.new(:message=>'Test tweet')
        @t.zombie = @ash
        @t.save!
      end

      it "should display a like tweet button for each tweet" do
        visit zombie_path(@ash)
        within "#zombie_tweets .like_update" do
          page.should have_selector "input[type='submit'][value='Like']"
        end
      end

      it "should display the tweet rating for each tweet" do
        visit zombie_path(@ash)
        within "#zombie_tweets thead" do
          page.should have_content 'Rating'
        end
      end

      it "should increment the rating after clicking like button" do
        @t.rating.should == 0
        t_id = @t.id
        visit zombie_path(@ash)
        within "#tweet_#{@t.id}" do
          click_button "Like"
        end

        page.current_path.should == zombie_path(@ash)
        t = Tweet.find(t_id)
        t.rating.should == 1
      end
    end
  end

  describe "editing" do
    before do
      @zombie = Zombie.create(:name=>"Ash", :weapon=>'axe')
    end
    it "should edit the zombie" do
      # Given that I'm on the show page for a zombie named "Ash"
      visit zombie_path(@zombie)

      # When I click the "edit" button
      page.should have_link "Edit", href: edit_zombie_path(@zombie)
      click_link "Edit"

      # Then I should be able to edit the zombies name, graveyard, and weapon
      fill_in "Name", :with=>"David"
      fill_in "Graveyard", :with=>"Cedarville Cemetary"
      fill_in "Nickname", :with=>"Hruuungh"
      fill_in "Description", :with=>"The zombie smells bad"
      attach_file "Avatar", 'test/fixtures/zombie.jpg'
      fill_in "Weapon", :with => 'Axe'

      # When I click "Update Zombie"
      click_button "Update Zombie"

      # Then it should save the changes
      page.should have_selector "input[value='David']"
      page.should have_selector "input[value='Cedarville Cemetary']"
      page.should have_selector "input[value='Hruuungh']"
      page.should have_selector "input[value='The zombie smells bad']"
      page.should have_selector "img[alt='Zombie']"

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
       @roy = Zombie.create(:name=>'Roy', :weapon => 'axe')
       @sarah = Zombie.create(:name=>'Sarah', :weapon => 'axe')
    end
      it "should edit the zombie creator" do
        #Given that I am on the edit page for a zombie named "Ash"
        visit edit_zombie_path(@zombie)
        # Then I should be able to edit the zombies creator
        select 'Sarah', :from => 'Creator'
        click_button "Update Zombie"
        page.has_select?('zombie_creator_id', :selected => "Sarah").should == true
        #page.should have_css  'div.creator :option, :value => 'Sarah'
       end
    end

  end

  describe "adding tweet for zombie" do
    before do
      logmein
      @zombie = Zombie.create(:name=>"Ash", :graveyard=>"Duke Memorial",:weapon => 'axe' )
    end
    it "should add a tweet for a zombie" do
      #Given I'm on the show page for a zombie
      visit zombie_path(@zombie)

      #When I fill in the tweet and click save
      fill_in "tweet_message", with: "Hello, World!"

      #When I fill in the tweet and click save
      fill_in "tweet_message", :with=>"Hello, World!"
      click_button "Add Tweet"

      #Then it should save the tweet
      #And I should see the zombie show page
      current_path.should == zombie_path(@zombie)
      #And I should see the message "Tweet Added"
      page.should have_content "Tweet Added"
      #And I should see the new tweet in the list of tweets
      page.should have_content "Hello, World!"
    end
  end

  describe "searching for a zombie" do
    before do
      @zombie = Zombie.create!(:name => 'Rob Zombie', :weapon => 'rubber chicken', :nickname => 'Hrr', :graveyard => "Some graveyard", :description => 'A musical zombie.')
    end
    it "should find results for the search 'Rob'" do
      visit zombies_path
      fill_in "q", :with=>"Rob"
      click_button "Search Zombies"
      page.should have_content "Rob Zombie"
    end

    it "should find results for the search 'musical'" do
      visit zombies_path
      fill_in "q", :with=>"musical"
      click_button "Search Zombies"
      page.should have_content "A musical zombie"
    end

    it "should find NO results for the search 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'" do
      visit zombies_path
      fill_in "q", :with=>"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
      click_button "Search Zombies"
      page.should have_content "No zombies found"
    end

  end

  describe "history" do
    before do
      @ash = Zombie.create(:name=>'Ash', :graveyard=>'Cedarville Cemetary', :description=> "The zombie smells bad", :weapon => 'axe')
    end

    it "should display a description of a zombie" do
      visit zombie_history_path(@ash)

      page.should have_content "History for Zombie Ash"
      page.should have_content "create"
    end
  end


end
