class VideosController < ApplicationController

  before_action :require_user, only: [:home, :show, :search]

  def index
    #this is the index for all UI
  end

  def home                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    @reviews = @video.reviews
    render 'video'
  end

  def search
    @result = Video.search_by_title(params[:search_term])
  end

  def front; end

end
