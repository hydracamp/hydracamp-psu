class Zombie < ActiveRecord::Base
  attr_accessible :graveyard, :name, :description, :nickname, :hit_points
  
  validates :name, :presence=>true, :uniqueness=>true
  has_many :tweets, :dependent => :destroy
<<<<<<< HEAD

  # Set some defaults for values that may be nil
  after_initialize :init

  def init
    self.hit_points ||= 100
  end
=======
  belongs_to :creator, :class_name=>'Zombie'
>>>>>>> HCAMPPSU-8: Added creator to zombie to allow a zombie to identify the creator
end
