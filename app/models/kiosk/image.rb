module Kiosk
  class Image < ActiveRecord::Base
  	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  	belongs_to :product

  	def thumbnail
  		image.url(:thumb)
  	end

  	def img_path
  		image.url()
  	end
  	
  end
end
