class User < ActiveRecord::Base
  validates_presence_of :email, :first_name, :last_name, :password, :password_confirmation

  has_secure_password
end
