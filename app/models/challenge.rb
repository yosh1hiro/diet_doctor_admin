class Challenge < ActiveRecord::Base
  has_many :levels, dependent: :destroy
  accepts_nested_attributes_for :levels

  attr_accessor :levels

  validates :group, :numericality => {only_integer: true}
  validates :group, :uniqueness => true

  after_find do
    @levels = Level.where(group: group).order(:level).to_a
  end

  def image_file=(file)
    self.image = file.read
  end
end
