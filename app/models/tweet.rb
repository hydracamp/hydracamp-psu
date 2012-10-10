class Tweet < ActiveFedora::Base
  belongs_to :zombie, :property=>:created_by
  #attr_accessible :message, :deleted_at, :rating
  delegate_to :eac_cpf, [:message, :resource_type, :creator, :date_created, :likes, :likers], :unique=>true
  delegate_to :eac_cpf, [:likers]
  has_metadata :name => "eac_cpf", :type => TweetRdfDatastream

  validates :zombie, :presence=>true
  #acts_as_paranoid

  after_initialize :init

  def init
    self.likes ||= 0
  end
end
