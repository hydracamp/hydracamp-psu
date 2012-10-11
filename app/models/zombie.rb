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
  has_metadata :name => 'EAC-CPF', :type => ZombieEacCpf
  has_metadata :name => 'ZombieCrap', :type => ActiveFedora::SimpleDatastream do |d|
    d.field :active, :string
    d.field :hit_points, :string
    d.field :level, :string
    d.field :wins, :string
    d.field :losses, :string
  end

  delegate_to 'EAC-CPF', [:name, :nickname, :graveyard, :weapon, :date_of_birth, :date_of_death, :date_of_undeath], :unique => true
  delegate :description, :to => "EAC-CPF", :at => [:description_of_life], :unique=>true
  delegate_to 'ZombieCrap', [:active, :hit_points, :level, :wins, :losses], :unique => true

  include Casting 

  def active
  	 cast_to_boolean_unless_blank_from_om('ZombieCrap',:active)
  end
  def active?
  	active
  end

  def to_solr(doc = {} )
    doc = super(doc)
    doc['name_sort'] = doc['name_t'].first
    doc['graveyard_facet'] = doc['graveyard_t']
    doc
  end

  def date_of_death
  	 cast_to_date_from_om('EAC-CPF',:date_of_death)
  end
  def date_of_death=(date)
  	 serialize_to_om('EAC-CPF',:date_of_death, date)
  end
  def date_of_birth
  	 cast_to_date_from_om('EAC-CPF',:date_of_birth)
  end
  def date_of_undeath
  	 cast_to_date_from_om('EAC-CPF',:date_of_undeath)
  end

  def hit_points
  	 cast_to_integer_unless_blank_from_om('ZombieCrap',:hit_points)
  end

  def wins
  	 cast_to_integer_unless_blank_from_om('ZombieCrap',:wins)
  end

  def losses
  	 cast_to_integer_unless_blank_from_om('ZombieCrap',:losses)
  end

  def level
  	 cast_to_integer_unless_blank_from_om('ZombieCrap',:level)
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

