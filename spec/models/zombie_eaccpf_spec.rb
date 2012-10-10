require 'spec_helper'

describe ZombieEacCpf do

  before do
    @eac_cpf_xml = File.new(File.join(File.dirname(__FILE__),'..', 'fixtures', "zombie-simple.eac-cpf.xml"))
    @ds = ZombieEacCpf.from_xml(@eac_cpf_xml)
  end

  # creator (of the eac-cpf record)
  # name, nickname, date_of_birth, date_of_death, date_of_undeath, description_of_life (abstract), description_of_undeath (abstract)
  # graveyard
  # weapon
  
  it "should have creator" do
    @ds.creator.first.should == "W.B. Yeats"
  end
  
  it "should have graveyard" do
    @ds.graveyard.first.should == "Creepy Hollow"
    @ds.graveyard = "Creepy Holloween"
    @ds.graveyard.first.should == "Creepy Holloween"
  end
  it "should have weapon" do
    @ds.weapon.first.should == "Chainsaw"
  end
  
  it "should have description_of_life and description_of_undeath" do
    @ds.description_of_life.first.should == "Biographic info from Life..."
    @ds.description_of_life = "NEW Biographic info from Life..."
    @ds.description_of_life.first.should == "NEW Biographic info from Life..."


    @ds.description_of_undeath.first.should == "Biographic info from Undeath..."
    @ds.description_of_undeath = "NEW Biographic info from Undeath..."
    @ds.description_of_undeath.first.should == "NEW Biographic info from Undeath..."
  end
  
  it "should have a date of birth" do
    # @ds.cpf_description.description.exist_dates.life_dates.from.standard.first.should == '1742-11-12'
    @ds.date_of_birth.first.should == "1742-11-12"
    @ds.date_of_birth = "1999-10-22"
    @ds.date_of_birth.first.should == "1999-10-22"
  end

  it "should have a date of death" do
    # @ds.cpf_description.description.biog_hist.chron_list.chron_item.date[1].should == '1802-12-27'
    # @ds.cpf_description.description.exist_dates.life_dates.to.standard.first.should == '1802-12-27'
    @ds.date_of_death.first.should == '1802-12-27'
  end
  
  it "should have a date of undeath" do
    # @ds.cpf_description.description.biog_hist.chron_list.chron_item.date[2].should == '1802-12-31'
    # @ds.cpf_description.description.exist_dates.undeath_dates.from.standard.first.should == '1802-12-31'
    @ds.date_of_undeath.first.should == '1802-12-31'
  end

  it "should access the name" do
    # @ds.cpf_description.identity.name_entry.part.should == ['Thomas Cadell']
    @ds.name.first.should == 'Thomas Cadell'
  end

  it "should be able to set the name" do
    @ds.name.first.should == 'Thomas Cadell'
    @ds.name = 'Thomas Cadellino'
    @ds.name.first.should == 'Thomas Cadellino'
  end
  

  it "should use the xml template" do
    pending
    ZombieEacCpf.new.to_xml.should be_equivalent_to ZombieEacCpf.xml_template
  end
end

