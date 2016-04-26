class Slideshow < ActiveRecord::Base
  mount_uploader :image_url, SliderUploader
  
  def self.get_all_slides
    self.all.order("created_at DESC")
  end
end
