class ZombieEacCpf < ActiveFedora::NokogiriDatastream

  set_terminology do |t|
    t.root(:path=>'eac-cpf', :xmlns=>'urn:isbn:1-931666-33-4')
    t.name(:path=>"cpfDescription/oxns:identity/oxns:nameEntry/oxns:part")
    # t.creator(:path=>"...")  
    # t.nickname(:path=>"...")
    # t.description_of_life(:path=>"...")
    # t.description_of_undeath(:path=>"...")
    # t.graveyard(:path=>"...")
    # t.weapon(:path=>"...")
    # t.date_of_birth(:path=>"...")
    # t.date_of_death(:path=>"...")
    # t.date_of_undeath(:path=>"...")
  end
  
  # Template is loaded from lib/zombie-default.eac-cpf.xml
  def self.xml_template
    Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', 'lib', "zombie-default.eac-cpf.xml")))
  end
end