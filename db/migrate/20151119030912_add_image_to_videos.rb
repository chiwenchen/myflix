class AddImageToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :image, :string
    add_column :videos, :thumb_image, :string
  end
end
