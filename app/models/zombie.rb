class Zombie < ActiveRecord::Base
  attr_accessible :graveyard, :name

  validates :name, :presence=>true, :uniqueness=>true

  has_many :tweets, :dependent => :destroy
end
