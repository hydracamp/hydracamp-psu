class Tweet < ActiveRecord::Base
  belongs_to :zombie
  attr_accessible :message, :deleted_at, :rating
  validates :zombie, :presence=>true  
  acts_as_paranoid
end
