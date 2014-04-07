class User < ActiveRecord::Base
  has_many :weights
  has_many :achievements
  has_many :counsels



end
