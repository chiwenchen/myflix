class VideosController < ApplicationController

  before_action :require_user, only: [:home, :show, :search]

  def index
    #this is the index for all UI
  end

  def home                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
    @categories = Category.all
  end

  def show
    @video = VideoDecorator.decorate(Video.find(params[:id]))
    @reviews = @video.reviews
    respond_to do |format|
      format.html {render 'video'}
      format.js
    end
  end

  def search
    @result = Video.search_by_title(params[:search_term])
  end

  def advanced_search
    options = {
      reviews: params[:reviews],
      rating_from: params[:rating_from],
      rating_to: params[:rating_to]
    }

    if params[:query].present? 
      @videos = Video.search(params[:query], options).records.to_a
    else
      @videos = []
    end
  end

  def front; end

end
