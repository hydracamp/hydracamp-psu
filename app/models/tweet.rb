class Tweet < ActiveFedora::Base
  belongs_to :zombie, :property=>'created_by'
  #attr_accessible :message, :deleted_at, :rating
  delegate_to :simple, [:message, :deleted_at, :rating], :unique=>true
  has_metadata :name=>'simple', :type=>ActiveFedora::SimpleDatastream do |m|
    m.field 'message', :string
    m.field 'deleted_at', :datetime
    m.field 'rating', :string
  end

  validates :zombie, :presence=>true  
  #acts_as_paranoid
end
