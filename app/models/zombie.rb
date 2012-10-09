class Zombie < ActiveRecord::Base
  attr_accessible :graveyard, :name, :level

  validates :name, :presence=>true, :uniqueness=>true

  has_many :tweets, :dependent => :destroy

  before_save :default_values

  def default_values
    self.level ||= 1
  end
end
