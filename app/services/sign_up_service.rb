class SignUpService

  attr_accessor :user, :status, :message

  def initialize(user)
    @user = user
    @status = status
    @message = message
  end

  def signup(stripe_token, invitation_token = nil)
    token = stripe_token
    if user.valid?
      customer = customer(token, user)
      if customer.successful?
        user.customer_token = customer.customer_token
        user.save
        AppMailer.delay.send_welcome_message(@user)
        connect_user_and_inviter(user, invitation_token)
        @status = :success
        @message = 'You are successful Registed and Signed in'
      else
        @status = :warning
        @message = customer.error_message
      end
    else
      @status = :warning
      @message = 'user info is not valid, please fullfil the column highlighted'
    end
    self
  end

  def successful?
    self.status == :success
  end

  private

  def charge(token, user)
    StripeWrapper::Charge.create(
      amount: 999, 
      source: token,
      user: user,
      description: "Register fee for #{user.email}"
    )
  end

  def customer(token, user)
    StripeWrapper::Customer.create(token, user)
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