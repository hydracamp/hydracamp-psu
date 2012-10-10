class ZombieEacCpf < ActiveFedora::NokogiriDatastream

  set_terminology do |t|
    t.root(:path=>'eac-cpf', :xmlns=>'urn:isbn:1-931666-33-4')
    
    t.name(:path=>"cpfDescription/oxns:identity/oxns:nameEntry/oxns:part")
    t.creator(path: "control/maintenanceHistory/maintenanceEvent/agent")  
    t.nickname(path: "cpfDescription/identity/nameEntryParallel")
    t.description_of_life(path: "cpfDescription/description/biogHist[localType='life']/abstract")
    t.description_of_undeath(path: "cpfDescription/description/biogHist[localType='undeath']/abstract")
    t.graveyard(path: "cpfDescription/places/place[localType='graveyard']/placeEntry")
    t.date_of_birth(:path=>"cpfDescription/description/existDates/dateRange[localType='life']/fromDate")
    t.date_of_death(:path=>"cpfDescription/description/existDates/dateRange[localType='life']/toDate")
    t.date_of_undeath(:path=>"cpfDescription/description/existDates/dateRange[localType='undeath']/fromDate")
  end
  
  # Template is loaded from lib/zombie-default.eac-cpf.xml
  def self.xml_template
    Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', 'lib', "zombie-default.eac-cpf.xml")))
  end
end
