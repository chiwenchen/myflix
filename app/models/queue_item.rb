class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates :position, numericality: { only_integer: true }

  def video_title
    video.title
  end

  def rating 
    review = Review.where(user_id: user.id, video_id: video.id).first
    review == nil ? nil : review.rating
  end

  def rating= (new_rating)
    binding.pry
    review = Review.find_by(user_id: user.id, video_id: video.id)
    review.update(rating: new_rating) if review 
  end

  def category_title
    video.category.title
  end

  def category
    video.category
  end


end