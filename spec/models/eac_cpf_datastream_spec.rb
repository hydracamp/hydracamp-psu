require 'spec_helper'

describe ZombieEacCpf do
   describe "with new datastream" do
     before do
       @datastream = EacCpfDatastream.new
     end
     it "should have name" do
       test_attribute_xpath(@datastream, 'name', '/eac-cpf/cpfDescription/name')
     end
     it "should have graveyard" do
       test_attribute_xpath(@datastream, 'graveyard', '/eac-cpf/cpfDescription/location')
     end
     it "should have nickname" do
       test_attribute_xpath(@datastream, 'nickname', '/eac-cpf/cpfDescription/nickname')
     end
     it "should have active" do
       test_attribute_xpath(@datastream, 'active', '/eac-cpf/cpfDescription/active')
     end
     it "should have wins" do
       test_attribute_xpath(@datastream, 'wins', '/eac-cpf/cpfDescription/wins')
     end
     it "should have losses" do
       test_attribute_xpath(@datastream, 'losses', '/eac-cpf/cpfDescription/losses')
     end
     it "should have weapon" do
       test_attribute_xpath(@datastream, 'losses', '/eac-cpf/cpfDescription/weapon')
     end
     it "should have date_of_birth" do
       test_attribute_xpath(@datastream, 'date_of_birth', '/eac-cpf/cpfDescription/date_of_birth')
     end
     it "should have date_of_death" do
       test_attribute_xpath(@datastream, 'date_of_death', '/eac-cpf/cpfDescription/date_of_death')
     end
     it "should have date_of_undeath" do
       test_attribute_xpath(@datastream, 'date_of_undeath', '/eac-cpf/cpfDescription/date_of_undeath')
     end
   end
   describe "with existing datastream" do
     before do
       @datastream = EacCpfDatastream.from_xml("<do later>")
     end
     it "should have name" do
       test_existing_attribute(@datastream, 'name', 'Zombie')
     end
     it "should have graveyard" do
       test_existing_attribute(@datastream, 'graveyard', 'Graveyard')
     end
     it "should have nickname" do
       test_existing_attribute(@datastream, 'nickname', 'Nickname')
     end
     it "should have active" do
       test_existing_attribute(@datastream, 'active', 'Active')
     end
     it "should have wins" do
       test_existing_attribute(@datastream, 'wins', 'wins')
     end
     it "should have losses" do
       test_existing_attribute(@datastream, 'losses', 'losses')
     end
     it "should have weapon" do
       test_existing_attribute(@datastream, 'weapon', 'weapon')
     end
     it "should have date_of_birth" do
       test_existing_attribute(@datastream, 'date_of_birth', 'date_of_birth')
     end
     it "should have date_of_death" do
       test_existing_attribute(@datastream, 'date_of_death', 'date_of_death')
     end
     it "should have date_of_undeath" do
       test_existing_attribute(@datastream, 'date_of_undeath', 'date_of_undeath')
     end
   end
end
