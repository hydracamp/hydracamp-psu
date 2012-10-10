class ZombieEacCpf < ActiveFedora::NokogiriDatastream

  set_terminology do |t|
    t.root(:path=>'eac-cpf', :xmlns=>'urn:isbn:1-931666-33-4')
    
    t.name(:path=>"cpfDescription/oxns:identity/oxns:nameEntry/oxns:part")
    t.creator(path: "control/oxns:maintenanceHistory/oxns:maintenanceEvent/oxns:agent")  
    t.nickname(path: "cpfDescription/oxns:identity/oxns:nameEntryParallel/oxns:part")
    t.description_of_life(path: "cpfDescription/oxns:description/oxns:biogHist[@localType='life']/oxns:abstract")
    t.description_of_undeath(path: "cpfDescription/oxns:description/oxns:biogHist[@localType='undeath']/oxns:abstract")
    t.graveyard(path: "cpfDescription/oxns:places/oxns:place[@localType='graveyard']/oxns:placeEntry")
    t.weapon(path: 'cpfDescription/oxns:relations/oxns:resourceRelation[@resourceRelationType="wielderOf"]/oxns:relationEntry')

    t.date_of_birth(:path=>"cpfDescription/oxns:description/oxns:existDates/oxns:dateRange[@localType='life']/oxns:fromDate")
    t.date_of_death(:path=>"cpfDescription/oxns:description/oxns:existDates/oxns:dateRange[@localType='life']/oxns:toDate")
    t.date_of_undeath(:path=>"cpfDescription/oxns:description/oxns:existDates/oxns:dateRange[@localType='undeath']/oxns:fromDate")
  end
  
  # Template is loaded from lib/zombie-default.eac-cpf.xml
  def self.xml_template
    Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', '..', 'lib', "zombie-default.eac-cpf.xml")))
  end
end
