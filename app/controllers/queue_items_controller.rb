class QueueItemsController < ApplicationController

  before_action :require_user

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

  def update_queue_item
    begin
<<<<<<< HEAD
    update_positions_and_rating
=======
    #update_positions
    update_positions
>>>>>>> change_position
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:danger] = invalid.record.errors.full_messages.pop
      redirect_to queue_items_path
      return
    end
    normalize_the_position
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

  def update_positions_and_rating
    ActiveRecord::Base.transaction do  
      params[:queue_item].each do |item|
        item_obj = QueueItem.find(item['id'])
        item_obj.update_attributes!(:position => item['position'], :rating => item['rating']) if item_obj.user == current_user
      end
    end
  end

  def normalize_the_position
    current_user.queue_items.each_with_index do |item, index|
      item.update_attributes(:position => index + 1 )
    end
  end

end