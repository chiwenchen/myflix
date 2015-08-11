class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> {order(:position)}
  has_many :following_relationship, class_name: 'Relationship', foreign_key: :follower_id
  has_many :leading_relationship, class_name: 'Relationship', foreign_key: :leader_id
  has_secure_password validations: false
  validates_presence_of :name, :password, :email
  #validates_length_of [:name, :password], in: 4..20
  # validates_confirmation_of :name
  validates_uniqueness_of :name, :email

  def queued_video(video)
    queue_items.map(&:video).include? video
  end
end