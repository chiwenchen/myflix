class Invitation < ActiveRecord::Base
  validates_presence_of :inviter_id, :invitee_name, :invitee_email
  belongs_to :inviter, class_name: 'User'

  def param
    self.token
  end
end