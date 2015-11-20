class Video < ActiveRecord::Base
  belongs_to :category
  has_many :queue_items
  has_many :reviews, -> { order 'created_at DESC' }
  validates :title, presence: :true
  validates :description, presence: :true
  before_save :video_url_string

  mount_uploader :image, VideoImageUploader
  mount_uploader :thumb_image, ThumbImageUploader

  def self.search_by_title(search_term)
    #self.where(title: title.to_s)
    return [] if search_term.blank?
    self.where("title LIKE ?", "%#{search_term}%")
    #find(:all, :conditions => ['title LIKE ?', "%#{search_term}%"]) This is not working
  end

  def video_url_string
    string = self.video_url
    string.gsub!(/" frameborder/, %Q[?autoplay=1" frameborder])
    string.sub!(/560/, "665")
    string.sub!(/315/, "375")
    self.video_url = string
  end


end