class Zombie < ActiveRecord::Base
  attr_accessible :graveyard, :name, :nickname, :active, :wins, :losses

  validates :name, :presence=>true, :uniqueness=>true
  validates :active, :presence=>true
  validates :wins, :presence=>true
  validates :losses, :presence=>true

  has_many :tweets, :dependent => :destroy
end
