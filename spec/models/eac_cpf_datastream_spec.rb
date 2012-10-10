require 'spec_helper'

describe ZombieEacCpf do
   describe "with new datastream" do
     before do
       @datastream = ZombieEacCpf.new(nil,'EAC-CPF')
     end
     it "should have name" do
       test_attribute_xpath(@datastream, 'name', 'cpfDescription/oxns:identity/oxns:nameEntry/oxns:part')
     end
     it "should have graveyard" do
       test_attribute_xpath(@datastream, 'graveyard', "cpfDescription/places/place[localType='graveyard']/placeEntry")
     end
     it "should have nickname" do
       test_attribute_xpath(@datastream, 'nickname', 'cpfDescription/identity/nameEntryParallel')
     end
     #it "should have wins" do
     #  test_attribute_xpath(@datastream, 'wins', '/eac-cpf/cpfDescription/wins')
     #end
     #it "should have losses" do
     #  test_attribute_xpath(@datastream, 'losses', '/eac-cpf/cpfDescription/losses')
     #end
     it "should have weapon" do
       test_attribute_xpath(@datastream, 'weapon', '/eac-cpf/cpfDescription/weapon')
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
       file = File.new(File.join(File.dirname(__FILE__),'..' ,'fixtures', "zombie_eac-cpf_authorized.xml"))
       @datastream = ZombieEacCpf.from_xml(file)
     end
     it "should have name" do
       test_existing_attribute(@datastream, 'name', 'Cadell, Thomas')
     end
     it "should have graveyard" do
       test_existing_attribute(@datastream, 'graveyard', 'Creepy Hallow')
     end
     it "should have nickname" do
       test_existing_attribute(@datastream, 'nickname', 'GRRAH')
     end
     #it "should have wins" do
     #  test_existing_attribute(@datastream, 'wins', 'wins')
     #end
     #it "should have losses" do
     #  test_existing_attribute(@datastream, 'losses', 'losses')
     #end
     it "should have weapon" do
       test_existing_attribute(@datastream, 'weapon', 'Chainsaw')
     end
     it "should have date_of_birth" do
       test_existing_attribute(@datastream, 'date_of_birth', '1742-11-12')
     end
     it "should have date_of_death" do
       test_existing_attribute(@datastream, 'date_of_death', '1802-12-27')
     end
     it "should have date_of_undeath" do
       test_existing_attribute(@datastream, 'date_of_undeath', '1802-12-31')
     end
   end
end
