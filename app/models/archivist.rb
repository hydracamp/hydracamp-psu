class Archivist < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :points

  before_save :set_defaults

  def level
    case points 
      when 100
        "Flesh Apprentice"
      when 200
        "Cadaver Expert"
      when 200
        "Cranium Master"
      end
  end
    
protected
        
  def set_defaults
    self.points = 100
  end
  
  # attr_accessible :title, :body
end
