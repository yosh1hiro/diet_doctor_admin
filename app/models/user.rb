class User < ActiveRecord::Base
  has_many :weights,      :dependent => :delete_all
  has_many :achievements, :dependent => :delete_all
  has_many :counsels

  attr_accessor :password
  attr_accessible :name

  before_save do
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticated_user(params)
    user = User.where(name: params[:user][:name])
    if user && BCrypt::Password.new(user.password_digest) == params[:user][:password]
      user
    else
      nil
    end
  end
end
