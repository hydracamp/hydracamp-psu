require 'spec_helper'

describe ZombieEacCpf do
   describe "with new datastream" do
     before do
       @datastream = ZombieEacCpf.new(nil,'EAC-CPF')
     end
     it "should have name" do
       test_attribute_xpath(@datastream, 'name', '//oxns:cpfDescription/oxns:identity/oxns:nameEntry/oxns:part')
     end
     it "should have creator" do
       test_attribute_xpath(@datastream, 'creator', '//oxns:control/oxns:maintenanceHistory/oxns:maintenanceEvent/oxns:agent')
     end
     it "should have graveyard" do
       test_attribute_xpath(@datastream, 'graveyard', "//oxns:cpfDescription/oxns:places/oxns:place[@localType='graveyard']/oxns:placeEntry")
     end
     it "should have nickname" do
       test_attribute_xpath(@datastream, 'nickname', "//oxns:cpfDescription/oxns:identity/oxns:nameEntryParallel/oxns:part")
     end
     #it "should have wins" do
     #  test_attribute_xpath(@datastream, 'wins', '/eac-cpf/cpfDescription/wins')
     #end
     #it "should have losses" do
     #  test_attribute_xpath(@datastream, 'losses', '/eac-cpf/cpfDescription/losses')
     #end
     it "should have description_of_life" do
       test_attribute_xpath(@datastream, 'description_of_life', "//oxns:cpfDescription/oxns:description/oxns:biogHist[@localType='life']/oxns:abstract")
     end
     it "should have description_of_undeath" do
       test_attribute_xpath(@datastream, 'description_of_undeath', "//oxns:cpfDescription/oxns:description/oxns:biogHist[@localType='undeath']/oxns:abstract")
     end
     it "should have weapon" do
       test_attribute_xpath(@datastream, 'weapon', '//oxns:cpfDescription/oxns:relations/oxns:resourceRelation[@resourceRelationType="wielderOf"]/oxns:relationEntry')
     end
     it "should have date_of_birth" do
       test_attribute_xpath(@datastream, 'date_of_birth', "//oxns:cpfDescription/oxns:description/oxns:existDates/oxns:dateRange[@localType='life']/oxns:fromDate")
     end
     it "should have date_of_death" do
       test_attribute_xpath(@datastream, 'date_of_death', "//oxns:cpfDescription/oxns:description/oxns:existDates/oxns:dateRange[@localType='life']/oxns:toDate")
     end
     it "should have date_of_undeath" do
       test_attribute_xpath(@datastream, 'date_of_undeath', "//oxns:cpfDescription/oxns:description/oxns:existDates/oxns:dateRange[@localType='undeath']/oxns:fromDate")
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
     it "should have creator" do
       test_existing_attribute(@datastream, 'creator', 'williambutler@yeats.com')
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
     it "should have description_of_life" do
       test_existing_attribute(@datastream, 'description_of_life', 'Biographic info from Life...')
     end
     it "should have description_of_undeath" do
       test_existing_attribute(@datastream, 'description_of_undeath', 'Biographic info from Undeath...')
     end
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
