class Tweet < ActiveFedora::Base
  has_metadata :name => 'TweetData', :type => ActiveFedora::SimpleDatastream do |c|
    c.field :message, :string
    c.field :deleted_at, :datetime
    c.field :rating, :string
    c.field :created_at, :datetime
  end
  include Casting

  belongs_to :zombie, :property => :created_by

  delegate_to 'TweetData', [:message, :deleted_at, :created_at], :unique => true

  def created_at
  	 cast_to_date_from_om('TweetData',:created_at)
  end

  def rating
    cast_to_integer_unless_blank_from_om('TweetData', :rating)
  end

  def rating=(int)
    serialize_to_om('TweetData', :rating, int)
  end

  validates :zombie, :presence=>true

  before_save :set_created_date

  def set_created_date
    self.created_at = Date.today.to_s
  end

  def to_solr (doc = {}) 
    super(doc)
    doc['created_at_sort'] = doc['created_at_t'].first
    doc
  end

  after_initialize :init

  def init
    self.rating ||= 0
  end

end
