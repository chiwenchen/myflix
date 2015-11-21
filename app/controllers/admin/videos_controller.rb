class Admin::VideosController < Admin::AdminController
  def new
    @video = Video.new  
  end
 
  def create
    @video = Video.new(strong_params)
    if @video.save
      flash[:success] = 'You have successfully added a new video'
      redirect_to new_admin_video_path  
    else
      render :new
    end
    
  end
end

private

def strong_params
  params.require(:video).permit(:title, :description, :category_id, :image, :thumb_image, :video_url)
end
