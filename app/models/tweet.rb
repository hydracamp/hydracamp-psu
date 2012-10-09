class Tweet < ActiveRecord::Base
  belongs_to :zombie
  attr_accessible :message, :deleted_at
  
  acts_as_paranoid
end
