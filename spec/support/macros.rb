def set_current_user
  sammy = Fabricate(:user, name: 'sammy')
  session[:user_id] = sammy.id
end

def sammy # is our current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end