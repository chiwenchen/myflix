# encoding: utf-8

class ThumbImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  process resize_to_fit: [166, 236]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end
