class Guest < User

  def guest?
    true
  end
  
  def move_to(user)
    channels.update_all(user_id: user.id)
  end
  
end
