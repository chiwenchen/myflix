def set_current_user
  sammy = Fabricate(:user, name: 'sammy')
  session[:user_id] = sammy.id
end

def set_current_admin
  admin = Fabricate(:admin, name: 'admin')
  session[:user_id] = admin.id
end

def sammy # is our current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def sign_in(user = nil)
  #we can use feature spec syntax in macros
  user ||= Fabricate(:user)
  visit signin_path
  fill_in 'Email Address', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end

def new_video(title)
  Fabricate(:video, title: title)
end