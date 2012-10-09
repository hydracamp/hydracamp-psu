class NicknameValidator < ActiveModel::Validator
  def validate(record)
    if (record.nickname =~ /[^hrungoaHRUNGOA]/i )
      record.errors[:nickname] << "Nickname contains invalid characters"
    end
  end
end

class Zombie < ActiveRecord::Base
  attr_accessible :graveyard, :name, :nickname, :level, :nickname, :hit_points, :description

  validates :name, :presence=>true, :uniqueness=>true
  validates_with NicknameValidator
  has_many :tweets, :dependent => :destroy
  belongs_to :creator, :class_name=>'Zombie'

  before_save :default_values

  def default_values
    self.level ||= 1
  end
  # Set some defaults for values that may be nil
  after_initialize :init

  def init
    self.hit_points ||= 100
  end
end

