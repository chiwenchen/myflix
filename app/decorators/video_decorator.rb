class VideoDecorator < Draper::Decorator
  delegate_all

  def rating
    object.reviews.present? ? "#{object.rating} / 5.0" : "N/A"
  end
end