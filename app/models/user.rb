class User < ActiveRecord::Base

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :password_digest

  validates_presence_of :email, :first_name, :last_name, :password, :password_confirmation

  has_many :channels, dependent: :destroy

  has_secure_password

end
