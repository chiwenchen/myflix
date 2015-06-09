class VideosController < ApplicationController
  def index

  end

  def home
    @categories = Category.all
  end

  def show
    @video = Video.find(params[:id])
    render 'video'
  end

  def search
    @result = Video.search_by_title(params[:search_term])
  end

  def front
  end

  

end
