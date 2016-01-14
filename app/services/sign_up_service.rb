class SignUpService

  attr_accessor :user, :status, :message

  def initialize(user)
    @user = user
    @status = status
    @message = message
  end

  def signup(invitation_token, stripe_token)
    token = stripe_token
    if user.valid?
      @charge_card = charge_card(token, user)
      if @charge_card.successful?
        user.save
        AppMailer.delay.send_welcome_message(@user)
        connect_user_and_inviter(user, invitation_token)
        @status = :success
        @message = 'You are successful Registed and Signed in'
        self
      else
        @status = :warning
        @message = @charge_card.response.to_s
        self
      end
    else
      @status = :warning
      @message = 'user info is not valid, please fullfil the column highlighted'
      self
    end
  end

  private

  def charge_card(token, user)
    charge = StripeWrapper::Charge.create(
      amount: 999, 
      source: token,
      description: "Register fee for #{user.email}"
    )
  end

  def connect_user_and_inviter(user, invitation_token)
    if invitation_token
      @invitation = Invitation.find_by(token: invitation_token)
      inviter = User.find(@invitation.inviter_id)
      user.follow(inviter)
      inviter.follow(user)
    end
  end

end