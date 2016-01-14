class UsersController < ApplicationController

  before_action :require_user, only: [:people]

  def new
    if logged_in?
      redirect_to home_path
    end
    @user = User.new
  end

  def new_with_invitation
    if logged_in?
      redirect_to home_path
    else
      @invitation = Invitation.find_by(token: params[:invitation])
      @user = User.new(email: @invitation.invitee_email)
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(strong_params)
    result = SignUpService.new(@user).signup(params[:invitation_token], params[:stripeToken])
    flash[result.status] = result.message
    if result.status == :success
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render 'new'
    end
  end

  private

  def strong_params
    params.require(:user).permit(:name, :password, :email)
  end


end