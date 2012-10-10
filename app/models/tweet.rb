class Tweet < ActiveFedora::Base
  has_metadata :name => 'TweetData', :type => ActiveFedora::SimpleDatastream do |c|
    c.field :message, :string
    c.field :deleted_at, :datetime
    c.field :rating, :string
    c.field :created_at, :datetime
  end
  belongs_to :zombie, :property => :created_by

  delegate_to 'TweetData', [:message, :deleted_at, :rating, :created_at], :unique => true

  validates :zombie, :presence=>true

end
