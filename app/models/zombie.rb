class NicknameValidator < ActiveModel::Validator
  def validate(record)
    if (record.nickname =~ /[^hrungoa!]/i )
      record.errors[:nickname] << "contains invalid characters"
    end
  end
end

class UniquenessValidator < ActiveModel::Validator
  def validate(record)
  	    puts "looking for '#{record.name}'"
  	    puts Zombie.count(q:"name_t:'#{record.name}'")
    if (Zombie.count(q:"name_t:'#{record.name}'")>0)
      record.errors[:name] << "is not unique"
    end
  end
end

class Zombie < ActiveFedora::Base
  has_metadata :name => 'EAC-CPF', :type => ActiveFedora::SimpleDatastream do |c|
    c.field :name, :string
    c.field :nickname, :string
    c.field :graveyard, :string
    c.field :description, :string
    c.field :active, :string
    c.field :wins, :string
    c.field :losses, :string
    c.field :weapon, :string
    c.field :level, :string
    c.field :hit_points, :string
    c.field :date_of_birth, :string
    c.field :date_of_death, :string
    c.field :date_of_undeath, :string
  end

  delegate_to 'EAC-CPF', [:name, :nickname, :graveyard, :description, :active, :wins, :losses, :weapon, :level, :hit_points, :date_of_birth, :date_of_death, :date_of_undeath], :unique => true

  def cast_to_integer_unless_blank_from_om(dsid,field_name)
    v=self.datastreams[dsid].send(field_name).first
    unless v.blank?
      return v.to_i
    end
  end

  def cast_to_boolean_unless_blank_from_om(dsid,field_name)
    v=self.datastreams[dsid].send(field_name).first
    unless v.blank?
      return v=="true"
    end
  end
  def active
  	 cast_to_boolean_unless_blank_from_om('EAC-CPF',:active)
  end
  def active?
  	active
  end

  def cast_to_date_from_om(dsid,field_name)
    v=self.datastreams[dsid].send(field_name).first
  	   puts "v is #{v.inspect}"
    return v.nil? ? Date.today : Date.parse(v)
  end
  def date_of_death
  	 cast_to_date_from_om('EAC-CPF',:date_of_death)
  end
  def date_of_birth
  	 cast_to_date_from_om('EAC-CPF',:date_of_birth)
  end
  def date_of_undeath
  	 cast_to_date_from_om('EAC-CPF',:date_of_undeath)
  end

  def hit_points
  	 cast_to_integer_unless_blank_from_om('EAC-CPF',:hit_points)
  end

  def wins
  	 cast_to_integer_unless_blank_from_om('EAC-CPF',:wins)
  end

  def losses
  	 cast_to_integer_unless_blank_from_om('EAC-CPF',:losses)
  end

  def level
  	 cast_to_integer_unless_blank_from_om('EAC-CPF',:level)
  end

  validates :name, :presence=>true
  validates_with NicknameValidator
  #validates_with UniquenessValidator
  validates :active, :presence=>true
  validates :wins, :presence=>true
  validates :losses, :presence=>true
  validates :weapon, :presence=>true

  has_many :tweets, :dependent => :destroy, :property => :created_by
  belongs_to :creator, :class_name=>'Zombie', :property => :child_of

  after_initialize :init

  def init
    self.hit_points ||= "100"
    self.level ||= "1"
    self.losses ||= "0"
    self.wins ||= "0"
    self.active ||="true"
  end
end

