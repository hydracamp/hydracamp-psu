class ZombieEacCpf < ActiveFedora::NokogiriDatastream

  set_terminology do |t|
    t.root(:path=>'eac-cpf', :xmlns=>'urn:isbn:1-931666-33-4')
    t.creator(:path=>"control/oxns:maintenanceHistory/oxns:maintenanceEvent/oxns:agent")    
    t.name(:path=>"cpfDescription/oxns:identity/oxns:nameEntry/oxns:part")
    # t.nickname ???
    t.description_of_life(:path=>"cpfDescription/oxns:description/oxns:biogHist[@localType='living']/oxns:abstract")    
    t.description_of_undeath(:path=>"cpfDescription/oxns:description/oxns:biogHist[@localType='undead']/oxns:abstract")
    t.graveyard(:path=>"cpfDescription/oxns:description/oxns:places/oxns:place[oxns:placeRole='interrment']/oxns:placeEntry")
    t.weapon(:path=>"cpfDescription/oxns:relations/oxns:resourceRelation[@resourceRelationType='wielderOf']/oxns:relationEntry")
    t.date_of_birth(:path=>"cpfDescription/oxns:description/oxns:existDates/oxns:dateRange[@localType='living']/oxns:fromDate/@standardDate")
    t.date_of_death(:path=>"cpfDescription/oxns:description/oxns:existDates/oxns:dateRange[@localType='living']/oxns:toDate/@standardDate")
    t.date_of_undeath(:path=>"cpfDescription/oxns:description/oxns:existDates/oxns:dateRange[@localType='undead']/oxns:fromDate/@standardDate")
  end
  
  def self.xml_template
    Nokogiri::XML::Document.parse('<?xml version="1.0" encoding="UTF-8"?>
<eac-cpf xmlns="urn:isbn:1-931666-33-4"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xsi:schemaLocation="urn:isbn:1-931666-33-4 http://eac.staatsbibliothek-berlin.de/schema/cpf.xsd">
    <control>
   	 <recordId>P004686</recordId>
   	 <maintenanceStatus>new</maintenanceStatus>
   	 <maintenanceAgency>
   		 <agencyCode>AU-BS</agencyCode>
   		 <agencyName>Bright Sparcs</agencyName>
   	 </maintenanceAgency>
   	 <maintenanceHistory>
   		 <maintenanceEvent>
   			 <eventType>created</eventType>
   			 <eventDateTime>2006-03-28</eventDateTime>
   			 <agentType>human</agentType>
   			 <agent>Helen Hamilton for ANMHP</agent>
   			 <eventDescription>Record Created</eventDescription>
   		 </maintenanceEvent>
   	 </maintenanceHistory>
   	 <sources>
   		 <source xlink:href="http://nla.gov.au/anbd.aut-an35803761" xlink:type="simple">
   		 </source>
   	 </sources>
    </control>
    <cpfDescription>
   	 <identity>
   		 <entityId>P004686</entityId>
   		 <entityType>person</entityType>
   		 <nameEntry xml:lang="eng" scriptCode="Latn">
   			 <part localType="surname"></part>

   			 <part localType="forename"></part>
   			 <authorizedForm>AARC2</authorizedForm>
   		 </nameEntry>
   	 </identity>
   	 <description>
   		 <occupation>
   			 <term></term>
   		 </occupation>
   		 <biogHist>
   			 <p>foo</p>
   			 <chronList>
   				 <chronItem>
   					 <date></date>
   					 <event>Born</event>
   				 </chronItem>
   				 <chronItem>
   					 <date></date>
   					 <event>died</event>
   				 </chronItem>
   			 </chronList>
   		 </biogHist>
   	 </description>
    </cpfDescription>
</eac-cpf>
    ')
  end

end
