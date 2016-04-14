module Kiosk
  class Product < ActiveRecord::Base
  	has_many :images, dependent: :destroy 

  	validates :name, presence: true, uniqueness: true
  	validates :description, presence: true
  	validates :price, presence: true, numericality: true
  	validates :stock, numericality: true

  	belongs_to :product_category, foreign_key: 'product_category_id'

  	scope :uncategorized, -> {where(kiosk_product_category_id: nil)}
  end
end
