class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> { order 'created_at DESC'}
  validates :title, presence: :true
  validates :description, presence: :true

  def self.search_by_title(search_term)
    #self.where(title: title.to_s)
    return [] if search_term.blank?
    self.where("title LIKE ?", "%#{search_term}%")
    #find(:all, :conditions => ['title LIKE ?', "%#{search_term}%"]) This not working
  end
end