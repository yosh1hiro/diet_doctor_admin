class Level < ActiveRecord::Base
  belongs_to :challenge, dependent: :destroy

  def image_file=(file)
    self.image = file.read
  end
end
