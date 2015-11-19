class Admin::AdminController < ApplicationController 

  before_action :require_user, :require_admin

  private
  
  def require_admin
    if !@current_user.admin?
      flash[:warning] = "You are not permitted to visit this area"
      redirect_to root_path
    end 
  end

end

