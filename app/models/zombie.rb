class Zombie < ActiveRecord::Base
  attr_accessible :graveyard, :name, :nickname, :date_of_death

  validates :name, :presence=>true, :uniqueness=>true

  has_many :tweets, :dependent => :destroy
end
