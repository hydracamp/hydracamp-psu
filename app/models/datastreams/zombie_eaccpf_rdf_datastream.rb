require 'rdf'
class ZombieEaccpfRdfDatastream < ActiveFedora::NtriplesRDFDatastream
  # Declare the vocabularies you want to use
  @@EACCPF = RDF::Vocabulary.new('http://archivi.ibc.regione.emilia-romagna.it/ontology/eac-cpf/')
  @@BIO = RDF::Vocabulary.new('http://vocab.org/bio/0.1/')
  @@GRAVES = RDF::Vocabulary.new('http://rdf.muninn-project.org/ontologies/graves#')
  ## This is a fake vocabulary. Wouldn't take much to make one.
  @@UNDEAD = RDF::Vocabulary.new('http://undead.example.org/vocab/ns#')

  # Register the vocabularies with ActiveFedora
  register_vocabularies RDF::DC, RDF::FOAF, @@EACCPF, @@UNDEAD

  # Create mappings between DSL terms and predicates in vocabularies
  map_predicates do |map|
    map.creature_type(:to => 'type', :in => @@UNDEAD)
    map.creator(:in => RDF::DC)
    map.full_name(:to => 'name', :in => RDF::FOAF)
    map.nickname(:to => 'nick', :in => RDF::FOAF)
    map.birth(:in => @@BIO)
    map.death(:in => @@BIO)
    map.date_of_undeath(:to => 'created', :in => RDF::DC)
    map.description_of_life(:to => 'biography', :in => @@BIO)
    map.description_of_undeath(:to => 'unbiography', :in => @@UNDEAD)
    map.graveyard(:to => 'site_name', :in => @@GRAVES)
    map.weapon(:in => @@UNDEAD)
   end
end
