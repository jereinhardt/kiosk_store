module Kiosk
  class Order < ActiveRecord::Base

  	#states of the current order.  Can be "building", "confirming", "confirmed", and "shipped"

	  STATUSES = %w(building confirming paid confirmed shipped).freeze

	  after_initialize { self.status = STATUSES.first if status.blank? }

	  def building?
	  	status == 'building'
	  end

	  def building!
	  	self.status = "building"
	  	self.save!
	  end

	  def confirming?
	  	status == "confirming"
	  end

	  def confirming!
	  	self.status = "confirming"
	  	self.save!
	  end

	  def paid?
	  	status == 'paid'
	  end

	  def paid!
	  	self.status = 'paid'
	  	save!
	  end

	  def confirmed?
	  	status == "confirmed"
	  end

	  def confirmed!
	  	self.placed_at = Time.now
	  	self.status = "confirmed"
	  	self.save!
	  end

	  def shipped?
	  	status == "shipped"
	  end

	  def shipped!
	  	self.status = "shipped"
	  	self.shipped_at = Time.now
	  	self.save!
	  end


  end
end