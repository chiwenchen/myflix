class QueueItemsController < ApplicationController

  before_action :require_user, only: [:index, :create, :destroy]

  def index
    @queue_items = current_user.queue_items
  end

  def create 
    add_video_into_the_queue if video_is_not_in_the_queue
    redirect_to queue_items_path
  end

  def destroy
    deleted_item = my_queue.find(params[:id]).delete
    shift_items(deleted_item)
    redirect_to queue_items_path
  end

  private

  def video_is_not_in_the_queue
    !QueueItem.find_by(video_id: params[:video_id], user: current_user)
  end

  def add_video_into_the_queue
    QueueItem.create(video_id: params[:video_id], user: current_user, position: current_user.queue_items.count + 1)
  end

  def my_queue
    current_user.queue_items
  end

  def shift_items(deleted_item)
    my_queue.where("position > ?", deleted_item.position).each do |item|
      item.position -= 1
      item.save
    end
  end

end