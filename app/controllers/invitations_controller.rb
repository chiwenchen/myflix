class InvitationsController < ApplicationController
  before_action :require_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(strong_params.merge!(inviter_id: current_user.id))
    if @invitation.save
      @invitation.generate_token
      AppMailer.delay.send_invitation_letter(@invitation)
      flash[:success] = "You have sent out a invitation to #{@invitation.invitee_name}"
      redirect_to home_path
    else
      flash[:danger] = "You have missing some information, please try again"
      render :new
    end
  end

  private

  def strong_params
    (params.require(:invitation).permit(:inviter, :invitee_name, :invitee_email, :message))
  end


end