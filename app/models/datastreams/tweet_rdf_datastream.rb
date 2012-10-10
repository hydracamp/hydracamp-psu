require 'rdf'
class TweetRdfDatastream < ActiveFedora::NtriplesRDFDatastream
  @@REV = RDF::Vocabulary.new('http://purl.org/stuff/rev#')
  register_vocabularies RDF::DC, RDF::FOAF, RDF::SIOC, @@REV
  map_predicates do |map|
    map.resource_type(:to => 'type', :in => RDF)
    map.message(:to => 'content', :in => RDF::SIOC)
    map.creator(:in => RDF::DC)
    map.date_created(:to => 'created', :in => RDF::DC)
    map.likes(:to => 'rating', :in => @@REV)
    map.likers(:to => 'reviewer', :in => @@REV)
  end
end
