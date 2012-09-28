class Zombie < ActiveRecord::Base
  attr_accessible :graveyard, :name

  validates :name, :presence=>true, :uniqueness=>true
end
