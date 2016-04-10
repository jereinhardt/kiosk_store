# tax rates
tax_rate = Kiosk::TaxRate.create(rate: 9.3, applied_to_shipping_cost: false, applied_to_billing_address: false, applied_to_shipping_address: true, state_ids: [35])

# shipping methods

sm1 = Kiosk::ShippingMethod.create(name: 'Standard Shipping: 3 - 5 Days (Free)', cost: 0)
sm2 = Kiosk::ShippingMethod.create(name: 'Expidited Shipping: 3 Days', cost: 15)

#product categories

category = Kiosk::ProductCategory.create(name: 'Widgets', description: 'A widget for any ocassion.')

# get_file uploads a file for product images
def get_file_path(name)
	file = File.join(Kiosk.root, 'db', 'seed_data', name)
	file
end

#carete products and assign them to a category

product1 = Kiosk::Product.create(name: 'Standard Widget', description: "Our most standard widget.  Great for most situations.", stock: 10, price: 15, permalink: 'widget-standard', kiosk_product_category_id: category.id)
product2 = Kiosk::Product.create(name: 'Widget Delux', description: "A more heavy duty widget for those sticky situations.", stock: 12, price: 35, permalink: 'widget-delux', kiosk_product_category_id: category.id)
product3 = Kiosk::Product.create(name: 'Widget Supreme', description: "The best widget on the market.  Nothing will ever top this.", stock: 6, price: 75, permalink: 'widget-supreme', kiosk_product_category_id: category.id)

#build images for each product
Kiosk::Image.create(image: File.new(get_file_path('evolved.jpeg')), product_id: product1.id)
Kiosk::Image.create(image: File.new(get_file_path('talk.jpg')), product_id: product2.id)
Kiosk::Image.create(image: File.new( get_file_path('title.jpg')), product_id: product3.id)
Kiosk::Image.create(image: File.new(get_file_path('spring.jpg')), product_id: product1.id)
Kiosk::Image.create(image: File.new(get_file_path('picker.jpg')), product_id: product3.id)
Kiosk::Image.create(image: File.new(get_file_path('Typewriter.jpg')), product_id: product3.id)







