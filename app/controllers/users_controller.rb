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
    @invitation = Invitation.find_by(token: params[:invitation_token]) if params[:invitation_token]
    Stripe.api_key = ENV['SECRET_KEY']
    token = params[:stripeToken]

    if @user.valid?
      begin
        @user.save
        charge_card(token, @user)
        AppMailer.delay.send_welcome_message(@user)
        flash[:success] = 'You are successful Registed and Signed in'
        session[:user_id] = @user.id
        redirect_to home_path    
      rescue Stripe::CardError => e
        flash[:warning] = e.to_s
        redirect_to register_path
      end
      if @invitation
        inviter = User.find(@invitation.inviter_id)
        @user.follow(inviter)
        inviter.follow(@user)
      end
    else
      render 'new'
    end
  end

  private

  def strong_params
    (params.require(:user).permit(:name, :password, :email))
  end

  def charge_card(token, user)
    charge = Stripe::Charge.create(
      amount: 999, 
      currency: "usd",
      source: token,
      description: "Register fee for #{user.email}"
    )
  end

end