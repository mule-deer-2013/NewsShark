class Member < User

validates_presence_of :email, :first_name, :last_name

attr_accessible :email, :first_name, :last_name, :password, :password_confirmation

has_secure_password  
  
  def guest?
    false
  end
  
end
