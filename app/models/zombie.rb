class Zombie < ActiveRecord::Base
  attr_accessible :graveyard, :name, :nickname
  attr_accessible :hit_points

  validates :name, :presence=>true, :uniqueness=>true

  has_many :tweets, :dependent => :destroy
  
  after_initialize :init

  def init
    self.hit_points ||= 100
    self.level ||= 1
  end
end
