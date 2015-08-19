class ReviewsController < ApplicationController
  before_action :require_user, only: [:create]

  def create
    @review = Review.new(strong_params)
    @video = Video.find(params[:video_id])
    @review.video = @video
    @review.user = current_user
    if @review.save
      flash[:success] = 'you leave a review in this movie'
      redirect_to video_path(@video)
    else
      flash[:warning] = 'You miss the body'
      redirect_to video_path(@video)
    end
  end

  def strong_params
    (params.require(:review).permit(:rating, :body))
  end
  
end