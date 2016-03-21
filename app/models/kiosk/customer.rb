module Kiosk
  class Customer < ActiveRecord::Base
  	has_many :addresses
    has_many :orders
  	has_one :billing_address
  	has_one :shipping_address

    EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,6}\Z/i

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, format: EMAIL_REGEX, uniqueness: true

  	scope :newest_first, -> { order(created_at: :desc)}
  	scope :oldest_first, -> { order(created_at: :asc)}
  	scope :sort_by_name, -> { order(last_name: :asc)}

  	def full_name 
  		"#{first_name} #{last_name}"
  	end
  end
end
