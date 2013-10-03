class User < ActiveRecord::Base

  # attr_accessible :email, :first_name, :last_name, :password, :password_confirmation
  has_many :channels, dependent: :destroy

  
 
end
