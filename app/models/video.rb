class Video < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Serializing
  include Elasticsearch::Model::Callbacks
  index_name ['myflix', Rails.env].join('_')

  belongs_to :category
  has_many :queue_items
  has_many :reviews, -> { order 'created_at DESC' }
  validates :title, presence: :true
  validates :description, presence: :true
  before_save :video_url_string

  mount_uploader :image, VideoImageUploader
  mount_uploader :thumb_image, ThumbImageUploader

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    self.where("title LIKE ?", "%#{search_term}%")
  end

  def video_url_string
    string = self.video_url
    string.gsub!(/" frameborder/, %Q[?autoplay=1" frameborder])
    string.sub!(/560/, "665")
    string.sub!(/315/, "375")
    self.video_url = string
  end

  def rating
    reviews.average(:rating).to_f.round(1)
  end

  def self.search(query, options={})
    search_definition = {
      query: {
        multi_match:  {
          query:  query,
          fields:  ["title^100", "description^50"],
          operator: 'and'
        }
      }
    }

    if query.present? && options[:reviews]
      search_definition[:query][:multi_match][:fields] << "reviews.body"
    end

    if options[:rating_from].present? || options[:rating_to].present?
      search_definition[:filter] = {
        range: {
          rating: {
            gte: (options[:rating_from] if options[:rating_from].present?),
            lte: (options[:rating_to] if options[:rating_to].present?)
          }
        }
      }
    end
    __elasticsearch__.search(search_definition)
  end

  def as_indexed_json(option={})
    as_json(
      methods: [:rating],
      only: ['title', 'description'], 
            include: {
              reviews:{only: :body}
            }
          )
  end


end