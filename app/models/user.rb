class User < ActiveRecord::Base
  has_many :weights,      :dependent => :delete_all
  has_many :achievements, :dependent => :delete_all
  has_many :counsels

  attr_accessor :password

  before_create do
    self.auto_login_token = SecureRandom.hex
  end

  before_save do
    self.password_digest = BCrypt::Password.create(password)
  end

  def authenticate(password)
    BCrypt::Password.new(password_digest) == password
  end

  def self.authenticated_user(params)
    user = User.where(name: params[:name]).first
    if user && user.authenticate(params[:password])
      user
    else
      nil
    end
  end
end

