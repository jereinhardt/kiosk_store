module Kiosk
  class Image < ActiveRecord::Base
  	has_attached_file :image, 
      styles: { 
        medium: "300x300>", 
        thumb: "100x100>" 
      }, 
      :path => '/:class/:attachment/:id_partition/:style/:filename',
      :url => ':s3_domain_url'


  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  	belongs_to :product, class_name: "Kiosk::Product"

  	def thumbnail
  		image.url(:thumb)
  	end

  	def img_path
  		image.url()
  	end
  	
  end
end
