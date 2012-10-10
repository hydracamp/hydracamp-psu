class ZombieEacCpfOldsyntax < ActiveFedora::NokogiriDatastream

  set_terminology do |t|
    t.root(:path=>'eac-cpf', :xmlns=>'urn:isbn:1-931666-33-4')
    t.control {
      t.maintenance_history(:path=>"maintenanceHistory") {
        t.maintenance_event(:path=>"maintenanceEvent") {
          t.agent
        }
      }
    }
    t.cpf_description(:path=>'cpfDescription') {
      t.identity {
        t.name_entry(:path=>'nameEntry') {
          t.part
          t.first_name(:ref=>[:cpf_description, :identity, :name_entry, :part], :attributes=>{'localType'=>'forename'},:index_as=>[:searchable, :facetable])
          t.last_name(:ref=>[:cpf_description, :identity, :name_entry, :part], :attributes=>{'localType'=>'surname'},:index_as=>[:searchable, :facetable])
        }
      }
      t.description {
        t.exist_dates(:path=>"existDates") {
          t.date_range(:path=>"dateRange") {
            t.from(:path=>"fromDate") {
              t.text(:path=>"./text()")
              t.standard(:path=>{:attribute=> "standardDate"})
            }
            t.to(:path=>"toDate") {
              t.text(:path=>"./text()")
              t.standard(:path=>{:attribute=> "standardDate"})
            }
          }
          t.life_dates(:ref=>[:cpf_description, :description, :exist_dates, :date_range], :attributes=>{"localType"=>"living"})
          t.undeath_dates(:ref=>[:cpf_description, :description, :exist_dates, :date_range], :attributes=>{"localType"=>"undead"})
        }
        t.biog_hist(:path=>'biogHist') {
          t.abstract
          t.chron_list(:path=>'chronList') {
            t.chron_item(:path=>'chronItem') {
              t.date
            }
          }
        }
        t.living_biog_hist(:ref=>[:cpf_description, :description, :biog_hist], :attributes=>{'localType'=>'living'})
        t.undead_biog_hist(:ref=>[:cpf_description, :description, :biog_hist], :attributes=>{'localType'=>'undead'})
      }
    }
    t.creator(:proxy=>[:control, :maintenance_history, :maintenance_event, :agent])
    t.name(:proxy=>[:cpf_description, :identity, :name_entry, :part])
    # t.nickname ???
    t.description_of_life(:proxy=>[:cpf_description, :description, :living_biog_hist, :abstract])
    t.description_of_undeath(:proxy=>[:cpf_description, :description, :undead_biog_hist, :abstract])
    t.graveyard(:path=>"cpfDescription//oxns:description/oxns:places/oxns:place[oxns:placeRole='interrment']/oxns:placeEntry")
    t.weapon(:path=>"cpfDescription/oxns:relations/oxns:resourceRelation[@resourceRelationType='wielderOf']/oxns:relationEntry")
    # t.date_of_birth(:proxy=>[:cpf_description, :description, :exist_dates, :life_dates, :from, :standard])
    t.date_of_birth(:path=>"cpfDescription/oxns:description/oxns:existDates/oxns:dateRange[@localType='living']/oxns:fromDate/@standardDate")
    
    t.date_of_death(:proxy=>[:cpf_description, :description, :exist_dates, :life_dates, :to, :standard])
    t.date_of_undeath(:proxy=>[:cpf_description, :description, :exist_dates, :undeath_dates, :from, :standard])
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
