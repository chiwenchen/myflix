class Category < ActiveRecord::Base
  has_many :videos, -> {order(:title)}

  def recent_videos
    sorted_videos = self.videos.sort_by{|video| video.created_at}.reverse.first(6)
  end
  
end