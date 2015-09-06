class HardWorker
  include Sidekiq::Worker
  def perform(invitation_id)
    invitation = Invitation.find(invitation_id)
    AppMailer.send_invitation_letter(invitation).deliver
  end
end