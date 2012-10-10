class NicknameValidator < ActiveModel::Validator
  def validate(record)
    if (record.nickname =~ /[^hrungoa]/i )
      record.errors[:nickname] << "Nickname contains invalid characters"
    end
  end
end

class Zombie < ActiveFedora::Base
  has_metadata :name => 'EAC-CPF', :type => ActiveFedora::SimpleDatastream do |c|
    c.field :name, :string
    c.field :nickname, :string
    c.field :active, :string
    c.field :wins, :string
    c.field :losses, :string
    c.field :weapon, :string
    c.field :level, :string
    c.field :hit_points, :string
  end

  delegate_to 'EAC-CPF', [:name, :nickname, :active, :wins, :losses, :weapon, :level, :hit_points], :unique => true

  validates :name, :presence=>true
  validates_with NicknameValidator
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
  end
end

