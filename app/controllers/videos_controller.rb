class VideosController < ApplicationController
  def index

  end

  def home
    @categories = Category.all
  end

  def video
    @video = Video.find(params[:id])
  end

  

end
