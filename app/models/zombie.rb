class Zombie < ActiveRecord::Base
  attr_accessible :graveyard, :name, :description, :nickname, :hit_points
  
  validates :name, :presence=>true, :uniqueness=>true

  has_many :tweets, :dependent => :destroy

  # Set some defaults for values that may be nil
  after_initialize :init

  def init
    self.hit_points ||= 100
  end
end
