class Archivist < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model

  attr_accessible :email, :password, :password_confirmation, :remember_me, :points

  after_initialize :init

  def level
    case points 
      when nil
        self.points = 100
        self.save!
        "Flesh Apprentice"
      when 0..150
        "Flesh Apprentice"
      when 151..250
        "Cadaver Expert"
      when 251..1000
        "Cranium Master"
      end
  end
  
  def inc_points(num)
    self.points += num
    self.save!
  end
    
protected
        
  def init
    self.points ||= 100
  end

  # attr_accessible :title, :body

end
