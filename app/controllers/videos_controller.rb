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

  

end
