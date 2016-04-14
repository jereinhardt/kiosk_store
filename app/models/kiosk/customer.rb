module Kiosk
  class Customer < ActiveRecord::Base
  	has_many :addresses, class_name: "Kiosk::Address"
    has_many :orders, class_name: "Kiosk::Order"
  	has_one :billing_address, class_name: "Kiosk::BillingAddress"
  	has_one :shipping_address, class_name: "Kiosk::ShippingAddress"

    EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,6}\Z/i

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true#, format: EMAIL_REGEX,

  	scope :newest_first, -> { order(created_at: :desc)}
  	scope :oldest_first, -> { order(created_at: :asc)}
  	scope :sort_by_name, -> { order(last_name: :asc)}

  	def full_name 
  		"#{first_name} #{last_name}"
  	end
  end
end
