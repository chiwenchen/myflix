class User < ActiveRecord::Base
  has_many :reviews
  has_many :queue_items, -> {order(:position)}
  has_many :following_relationships, class_name: 'Relationship', foreign_key: :follower_id #I am the follower
  has_many :leading_relationships, class_name: 'Relationship', foreign_key: :leader_id #I am the leader
  has_secure_password validations: false
  validates_presence_of :name, :password, :email
  #validates_length_of [:name, :password], in: 4..20
  # validates_confirmation_of :name
  validates_uniqueness_of :name, :email
  validates :password, length: { within: 6..20 }

  def queued_video(video)
    queue_items.map(&:video).include? video
  end

  def followed?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end

  def follow(another_user)
    Relationship.create(follower: self, leader: another_user)
  end

  def can_follow?(another_user)
    !(followed?(another_user) || self == another_user)
  end

  def reset_password(new_password)
    self.password = new_password
    save
  end
end