require 'test_helper'

module Kiosk
  class TaxRateTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end

    def setup
    	@state1 = kiosk_states(:state1)
    	@state2 = kiosk_states(:state2)

    	@tax1 = kiosk_tax_rates(:tax1)
    end

  end
end
