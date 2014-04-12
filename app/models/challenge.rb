class Challenge < ActiveRecord::Base
  has_many :levels, dependent: :destroy

  attr_reader :levels

  validates :group, :numericality => {only_integer: true}
  validates :group, :uniqueness => true

  after_find do
    @levels = Level.where(group: group).order(:level).to_a  if @levels.nil?
  end
end
