class NicknameValidator < ActiveModel::Validator
  def validate(record)
    if (record.nickname =~ /[^hrungoa]/i )
      record.errors[:nickname] << "Nickname contains invalid characters"
    end
  end
end

class Zombie < ActiveFedora::Base
  delegate_to :eac_cpf, [:full_name, :nickname, :creature_type, :creator, :birth, :death, :date_of_undeath, :description_of_life, :description_of_undeath, :graveyard], :unique=>true
  delegate_to :eac_cpf, [:weapon]

  has_metadata :name => "eac_cpf", :type => ZombieEaccpfRdfDatastream

  validates :full_name, :presence=>true #, :uniqueness=>true
  validates :weapon, :presence=>true
  validates_with NicknameValidator

  has_many :tweets, :dependent => :destroy, :property=> :created_by
  belongs_to :creator, :class_name=>'Zombie', :property=> :child_of
end

