class NicknameValidator < ActiveModel::Validator
  def validate(record)
    if (record.nickname =~ /[^hrungoa]/i )
      record.errors[:nickname] << "Nickname contains invalid characters"
    end
  end
end

class Zombie < ActiveFedora::Base
  delegate_to :eac_cpf, [:name, :nickname,  :date_of_birth, :date_of_death, :date_of_undeath], :unique=>true
  delegate_to :simple, [:graveyard, :hit_points, :description, :active, :level, :wins, :losses, :weapon], :unique=>true

  has_metadata :name=>'simple', :type=>ActiveFedora::SimpleDatastream do |m|
    m.field 'graveyard', :string
    m.field 'hit_points', :string
    m.field 'description', :string
    m.field 'active', :string
    m.field 'level', :string
    m.field 'wins', :string
    m.field 'losses', :string
    m.field 'weapon', :string
  end
  has_metadata :name=>'eac_cpf', :type=>ActiveFedora::SimpleDatastream do |m| # Change to Eaccpf ds
    m.field 'name', :string
    m.field 'nickname', :string
    m.field 'date_of_birth', :string
    m.field 'date_of_death', :string
    m.field 'date_of_undeath', :string
  end

  validates :name, :presence=>true #, :uniqueness=>true
  validates_with NicknameValidator
  validates :active, :presence=>true
  validates :wins, :presence=>true
  validates :losses, :presence=>true
  validates :weapon, :presence=>true

  has_many :tweets, :dependent => :destroy, :property=> :created_by
  belongs_to :creator, :class_name=>'Zombie', :property=> :child_of

  after_initialize :init

  # Add zombie avatar (via paperclip library)
  #has_attached_file :avatar, :styles => { 
  #  medium: "300x300>", 
  #  thumb: "100x100>" },  
  #:default_url => '/assets/missing_:style.png'

  def init
    self.hit_points ||= 100.to_s
    self.level ||= 1.to_s
    self.wins ||= 0.to_s
    self.losses ||= 0.to_s
    self.active ||= true.to_s
  end
end

