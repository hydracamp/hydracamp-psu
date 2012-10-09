class Zombie < ActiveRecord::Base
<<<<<<< HEAD
  attr_accessible :graveyard, :name, :nickname, :level, :nickname, :hit_points

  validates :name, :presence=>true, :uniqueness=>true

  has_many :tweets, :dependent => :destroy

  before_save :default_values

  def default_values
    self.level ||= 1

  # Set some defaults for values that may be nil
  after_initialize :init

  def init
    self.hit_points ||= 100
  end
end
