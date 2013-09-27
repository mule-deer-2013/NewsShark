class User < ActiveRecord::Base

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation

  validates_presence_of :email, :first_name, :last_name, :password, :password_confirmation

  has_many :channels

  has_secure_password
end
