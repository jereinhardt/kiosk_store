module Kiosk
  class Address < ActiveRecord::Base
  	belongs_to :customer, class_name: "Kiosk::Customer"

  	ZIP_CODE_REGEX = /^[0-9]{5}$/

  	validates :name, presence: true
  	validates :street_1, presence: true
  	validates :zip_code, presence: true #, format: ZIP_CODE_REGEX
  	validates :state, presence: true
  end
end
