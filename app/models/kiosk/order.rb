module Kiosk
  class Order < ActiveRecord::Base

  	  require_dependency 'kiosk/order/status'
  	  require_dependency 'kiosk/order/actions'

  	  has_many :order_items, dependent: :destroy
  	  has_one :billing_address
  	  has_one :shipping_address

	  # belongs_to :tax_rate
	  belongs_to :shipping_method
	  belongs_to :customer

	  ZIP_CODE_REGEX = /\A[0-9]{5}\z/
	  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,6}\Z/i
	  PHONE_REGEX = /\A[+?\d\ \-x\(\)]{7,}\z/

	  with_options if: proc { |o| o.confirming? } do |order|
		  order.validates :billing_name, presence: true
		  order.validates :billing_street_1, presence: true
		  order.validates :billing_zip_code, presence: true#, format: ZIP_CODE_REGEX
		  order.validates :billing_city, presence: true
		  #order.validates :billing_email#, format: EMAIL_REGEX
		  #order.validates :billing_phone_number, format: PHONE_REGEX

		  order.validates :shipping_name, presence: true
		  order.validates :shipping_street_1, presence: true
		  order.validates :shipping_zip_code, presence: true#, format: ZIP_CODE_REGEX
		  order.validates :shipping_city, presence: true
		  #order.validates :shipping_email, format: EMAIL_REGEX
		  #order.validates :shipping_phone_number, format: PHONE_REGEX
	  end

	  scope :placed, -> { where("placed_at >= '2016-03-09 03:39:45'").order(placed_at: :desc) }
	  

	  # returns a decimal that is the sum of all the order item totals
	  # represents total before shipping and tax
	  def subtotal
	    if order_items.empty?
	      return 0
	    elsif order_items.size > 1
	      order_items.inject(0) {|sum, item| sum + item.total }
	    else 
	      order_items.first.total
	    end
	  end

	  # returns a decimal that is the cost of shipping
	  # cost of shipping does not include tax if tax can be applied to shipping
	  def shipping_cost
	    shipping_method_id != nil ? (ShippingMethod.find(shipping_method_id).cost) : (0)
	  end

	  # returns the decimal value of the tax cost
	  # checks to see if tax rate applies toa =  the order, and if it applies to the subtotal or subtotal + shipping cost
	  def tax_cost 
	    if (tax_rate != 0) && tax_rate.applied_to_shipping_cost
	      return ((subtotal + shipping_cost) * (tax_rate.rate / 100)).to_f
	    elsif (tax_rate != 0) && !tax_rate.applied_to_shipping_cost
	      return ((tax_rate.rate / 100) * subtotal).to_f
	    else
	      return 0
	    end
	    0
	  end

	  def tax_rate
	  	if !TaxRate.all.empty? 
		  	TaxRate.all.each do |r|
		  		if r.states_by_code.include?(billing_state) && r.applied_to_billing_address
		  			return r
		  		elsif r.states_by_code.include?(shipping_state) && r.applied_to_shipping_address
		  			return r
		  		else
		  			return 0
		  		end
		  	end
		else 
			return 0 
		end
	  end

	  # retuns to the decimal value of total cost of the order
	  def total
	    (tax_cost + subtotal + shipping_cost).to_f
	  end

	  # retunr the integer value of the total cost of the order in cents
	  def total_in_cents
	  	((tax_cost + subtotal + shipping_cost) * 100).to_i
	  end


	  

  end
end
