module Kiosk
  class ProductCategory < ActiveRecord::Base
  	has_many :products, class_name: "Kiosk::Product"

  	validates :name, presence: true, uniqueness: true
  	validates :description, presence: true
  end
end
