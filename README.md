= Kiosk

This project rocks and uses MIT-LICENSE.# Kiosk

Kiosk is an e-commerce engine that focuses on simplicity rather than an over-abundance of features.  It is intended to help entrepreneurs get their first products online by taking care of the back-end management, and allowing the user to build the front-end however they please.  Fully integrating Kiosk into your application may take a few steps, but all of them are simple.  Let's get started.  

## Installation 

To include Kiosk in your application, start by including it in your gemfile
```ruby
gem 'kiosk', :git => 'git://github.com/jereinhardt/kiosk_store.git'
```
Next, run `bundle install`.  After that, we need to install Kiosk's migrations and seed some data.  Start by running to following commands
```
rake db:migrate
rake kiosk:setup
```
Running `db:migrate` will run all of Kiosk's migrations to prepare your database.  Then, running `setup` will seed important information Kiosk uses to handle shipping and taxes.  It also creates the admin user `admin@example.com` who has a password of `password` (he isn't the smartest admin user).  You will use these the first time you try to log into Kiosk's administrator panel.

One more optional command to run is: 
```
rake kiosk:sample_data
```
This will insert some sample data into your database.  That way, it will be easier to take Kiosk out for a test drive.

The next setup task we need to take care of is configuring our app to work with Stripe.  By default, Kiosk uses Stripe to process payments.  In order to do this, you need to make a file in your `config/initializers/` directory called `stripe.rb`.  Insert the following code into that file:
```ruby
Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
  :secret_key      => ENV['STRIPE_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
```
This will allow Kiosk to user your Stripe account to process payments.  For the sake of testing, you can use the publishable key of `pk_test_6pRNASCoBOKtIshFeQd4XMUh` and the secret key of `sk_test_BQokikJOvBiI2HlWgH4olfQ2` in place of your actual keys.  These are test keys provided on teh Stripe website.  

Lastly, we need to mount our engine.  In you `routes.rb` file, insert the following:

```ruby
mount Kiosk::Engine => "/kiosk"
```
Now the administrator panel is all set up.  

## Putting Out the Products

Now that Kiosk is set up, we need to show off some products.  In `routes.rb` insert the following:
```ruby
  get 'products', to: 'products#index', as: 'products'
  get 'product/:id', to: 'products#show', as: 'product'
```
This will allow user to access the store by going to `app/products`.  Next, let's put the products out.  Start by generating a Products Controller in your command line
```
rails g controller Products
```
Then, in your `products_controller.rb` file, add the following code:

```ruby
def index
	@products = Kiosk::Product.all
end

def show
	@product = Kiosk::Product.find(params[:id])
end
```
Now that the controller has created an object for all of our products, we can use it in the view.  In `app/views/products/` create and `index.html.erb` file and insert the following code:

```
<h1>Widget Superstore!</h1>
<p>We sell widgets and widget accessories.</p>

<% @products.each do |product| %>

	<h3><%= link_to product.name, product_path(product) %></h3>
	<%= image_tag product.images.first.image.url(:medium) %>

	<p><%= number_to_currency product.price %></p>
	<p><%= product.description %></p>

<% end %>
```
Not the best looking storefront, but it does display each of our items.  Now we need to be able to inspect the individual items.  Our controller already has a `show` action that contains an object for a single product.  In the same `app/views/products/` directory, create a `show.html.erb` file, and insert the following code:

```
<%= notice if notice %> <%= alert if alert %>

<%= link_to 'Back to products', products_path %>  

<% if !current_order.order_items.empty? %> <!-- this comes later -->
	<%= link_to "shopping cart", cart_path %>
<% end %>

<h2><%= @product.name %></h2>
<%= image_tag @product.images.first.image.url(:medium) %> <br>

<%= number_to_currency @product.price %>

<%= form_tag buy_path(@product) do %>
	<%= label_tag 'Qunatity', :quantity %>
	<%= text_field_tag :quantity, 1%>
	<%= submit_tag 'Add to Cart' %>
<% end %>
```
Now we have a dedicated page for each product.

## Shopping Carts

The next step would be to allow the customer to add items to their cart.  First, we need to create an object for the current order.  In your `application_controller.rb` file, add the following:

```ruby 
def current_order 
	check_for_current_order
	@order ||= Kiosk::Order.find(session[:order_id])
end

def check_for_current_order
	unless session[:order_id]
		@order = Kiosk::Order.create
		session[:order_id] = @order.id
	end
end

helper_method :current_order, :check_for_current_order
```
Now we have an object that will keep track of what our customer has ordered.  

In `products_controller.rb` add the following:

```ruby 
def buy
	@product = Kiosk::Product.find(params[:id])
	current_order.order_items.add_item(@product, params[:quantity])
	redirect_to product_path(@product)
end
```
This action allows customer to add items to their order.  Whenever they submit the form we created on the `show` page, it will be submitted to and handled by the `buy` action. 

We should update our `routes.rb` file to accomodate this, and to create a `cart` route where customers can check on their current order.  Open the file and add the following: 

```ruby 
post 'product/:id', to: 'products#buy', as: 'buy'

match 'cart', to: "orders#index", as: 'cart', via: [:get, :patch]
```
The second route reference a controller we have yet to make, so let's do that now.  Run the command:
```
rails g controller Orders
```
In the newly generated `orders_controller.rb` add the following:
```
def index
end
```
Now that we have a route and action, let's make the view for the cart.  In `app/views/orders/` create an `index.html.erb` file and insert the following:

```
<%= link_to 'Continue Shopping', products_path %>
<br>
<h1>Shopping Cart</h1>
<br>
<% current_order.order_items.each do |item| %>
	product:  <%= item.name %> <br>
	price:    <%= number_to_currency item.cost %> <br>
	quantity: <%= item.quantity %> <br>
	total:    <%= number_to_currency item.total %> <br><br>
<% end %>

<p><strong>Total</strong>: <%= number_to_currency current_order.subtotal %></p>

<%= link_to "Checkout", checkout_path %>
```
This allows the user to see an itemized list of everything they have in their shopping cart.  You can create a link to the cart anywhere in your app by adding `<%= link_to "shopping cart", cart_path %>` to the page.

## Checkout And Payment

Now that our customer has been able to show around for a while, they are ready to checkout and pay.  First, let's add all of the routes for this process in our `routes.rb` file:

```ruby 
match 'checkout', to: 'orders#checkout', as: 'checkout', via: [:get, :post]
match 'shipping_method', to: 'orders#shipping', as: 'shipping_method', via: [:get, :patch]
match 'checkout/pay', to: 'orders#payment', as: 'payment', via: [:get, :post]
match 'checkout/confirm', to: 'orders#confirmation', as: 'confirmation', via: [:get, :post]
match 'checkout/charge', to: 'orders#charge', as: 'charge', via: [:get, :post]
match 'checkout/thanks', to: 'orders#thanks', as: 'thanks', via: [:get]
```

This might seem like a lot, so let's take it piece by piece

### checkout 

When they user decides they are ready to checkout, they will be taken to a checkout page where they can enter all of their billing and shipping information.  In the `orders_controller.rb ` add the following:

```ruby
def checkout
	@order = current_order

	if request.post?
		@order.confirm_order_params(order_params)
		redirect_to shipping_method_path
	end
end
```
This action will post to itself in order to process the customers information, then redirect to the next part of the checkout process.  At the bottom of the `orders_controller.rb` file, also make sure to add this:
```ruby
private 

def order_params
	params.require(:order).permit(:billing_name, :billing_phone_number, :billing_street_1, :billing_street_2, :billing_zip_code, :billing_city, :billing_email, :billing_state, :shipping_name, :shipping_phone_number, :shipping_street_1, :shipping_street_2, :shipping_zip_code, :shipping_city, :shipping_email, :shipping_state, :shipping_state_name, :shipping_method_id)
end
```
That way the order's attributes can be mass-assigned.  

Then, create a view for this action in the `app/views/orders/` directory called `checkout.html.erb` and use the following code:

```
<%if @order.errors.full_messages.any? %>
<% @order.errors.full_messages.each do |message| %>
<%= message %> <br>
<% end %>
<% end %>

<%= form_for @order, url: checkout_path, method: :post do |t| %>
<div class="container">
	<div class="col col-md-6">
		<h2>Billing Information</h2>
		<%= t.label :billing_name, "Name" %>
		<%= t.text_field :billing_name, class: 'form-control' %>

		<%= t.label :billing_phone_number, 'Phone' %>
		<%= t.text_field :billing_phone_number, class: 'form-control' %>

		<%= t.label :billing_street_1, "Street 1" %>
		<%= t.text_field :billing_street_1, class: 'form-control' %>

		<%= t.label :billing_street_2, "Street 2" %>
		<%= t.text_field :billing_street_2, class: 'form-control' %>

		<%= t.label :billing_zip_code, "Zip Code" %>
		<%= t.text_field :billing_zip_code, class: 'form-control' %>

		<%= t.label :billing_city, "City" %>
		<%= t.text_field :billing_city, class: 'form-control' %>

		<%= t.label :billing_email, "email" %>
		<%= t.text_field :billing_email, class: 'form-control' %>

		<%= t.label :billing_state, "State" %>
		<%= t.select :billing_state, Kiosk::State.sorted.collect {|s| [s.state_name, s.state_code]}, class: 'form-control' %>

	</div>

	<div class="col col-md-6">
		<h2>Shipping Information</h2>
		<%= t.label :shipping_name, "Name" %>
		<%= t.text_field :shipping_name, class: 'form-control' %>

		<%= t.label :shipping_phone_number, "Phone" %>
		<%= t.text_field :shipping_phone_number, class: 'form-control' %>

		<%= t.label :shipping_street_1, "Street 1" %>
		<%= t.text_field :shipping_street_1, class: 'form-control' %>

		<%= t.label :shipping_street_2, 'Street 2' %>
		<%= t.text_field :shipping_street_2, class: 'form-control' %>

		<%= t.label :shipping_zip_code, "Zip Code" %>
		<%= t.text_field :shipping_zip_code, class: 'form-control' %>

		<%= t.label :shipping_city, "City" %>
		<%= t.text_field :shipping_city, class: 'form-control' %>

		<%= t.label :shipping_email, "Email" %>
		<%= t.text_field :shipping_email, class: 'form-control' %>

		<%= t.label :shipping_state, "State" %>
		<%= t.select :shipping_state, Kiosk::State.sorted.collect {|s| [s.state_name, s.state_code]}, class: 'form-control' %>
	</div>
	<div class="row col col-md-12"><%= submit_tag "Submit", class: 'btn btn-default' %></div>
</div>

<% end %>
``` 
Now we have a form for the customer to fill out, submit, and if everything is in order, move on to the next part, picking a shipping method.

### Shipping Method

Next, the customer needs to be able to pick the shipping method they would like.  In your `orders_controller.rb` file, add the following action:
```ruby
def shipping
	@order = current_order
	@shipping_methods = Kiosk::ShippingMethod.all
	if params.include?(:order)
		current_order.update_attributes(order_params)
		redirect_to payment_path
	end
end
```
This is another action that posts to itself and then redirects forward.  Now we need to make a view in `app/views/orders/` named `shipping.html.erb ` that uses the following

```
<%= form_for @order, url: shipping_method_path, method: :patch do |s| %>
	<%= s.collection_radio_buttons :shipping_method_id, @shipping_methods, :id, :display_name %> <br>
	<%= submit_tag 'Submit', class: 'btn btn-default' %>
<% end %>
```

Now the user can select their shipping method.

### Payment

Since payments are handled by Stripe, the controller for this action is pretty simple.  In `orders_controller.rb` add:
```ruby 
def payment
end
```
Create a view in `app/views/order/` called `payment.html.erb` and add:

```
<%= stripe_form_helper %>

<div class="container">
	<%= form_tag confirmation_path, id: 'payment-form', method: :post do %>
		<div class="row"><span class="payment-errors co col-md-12"></span></div>
		<div class="row">
			<div class="col col-md-12">
				<%= label_tag nil, 'Carnd Number' %>
				<%= text_field_tag nil, 'xxxx-xxxx-xxxx-xxxx', data: {stripe: 'number'}, size: '20', class: 'form-control col col-md-12' %>
			</div>
		</div>
		<div class="row">
			<div class="col col-md-6">
				<%= label_tag nil, 'CVC' %>
				<%= text_field_tag nil, 'xxx', data: {stripe: 'cvc'}, size: '20', class: 'form-control' %>
			</div>
			<div class="col col-md-2">
				<%= label_tag nil, "Exp. Month (MM)" %>
				<%= text_field_tag nil, 'MM', data: {stripe: 'exp-month'}, size: '2', class: 'form-control' %>
			</div>
			<div class="col col-md-4">
				<%= label_tag nil, 'Exp Year (YYYY)' %>
				<%= text_field_tag nil, 'YYYY', data: {stripe: 'exp-year'}, size: '4', class: 'form-control' %>
			</div>
		</div>

		<div class="row">
			<%= submit_tag 'Submit Payment', class: 'btn btn-default' %>
		</div>
	<% end %>
</div>
```
The `strip_form_helper` is a helper method that invokes the javascript Stripe uses to handle payments.  This form will be submitted to the action in the next step in the checkout process, the confirmation:

### confirmation 

We want the customer to be able to look over the order summary and confirm they want to make a purchase.  In your `orders_controller.rb` file, create the following action: 

```ruby 
def confirmation
	if request.post? && !current_order.paid?
		current_order.accept_stripe_token(params[:stripeToken])
	end
end
```
This creates the confirmation action, which takes the token generated from the payment form in the previous step, and creates a Stripe Customer for the order.  The customer has not been charged yet, but their payment information has been saved.  The `.paid?` method checks to make sure that the customer has already filled out their credit card information, and that it has been validated by stripe.  Now we need a view that summarizes the order.  In `app/views/orders/` create `confirmation.html.erb` and add the following:
```
Subtotal: <%= number_to_currency current_order.subtotal %> <br>
Tax: <%= number_to_currency current_order.tax_cost %> <br>
Shipping: <%= number_to_currency current_order.shipping_cost %> <br>
Total: <%= number_to_currency current_order.total %> <br>

<%= notice if notice %>

<%= link_to "Confirm Order", charge_path, class: 'btn btn-default' %>
```
This shows the customer what their order looks like and creates a link at the bottom which, when clicked, will charge their card by directing them to the next step
### Charge and Thanks
Once our customer has confirmed their order, we want to charge their card.  Create the following action in your `orders_controller.rb` file:
```ruby 
def charge 
	current_order.charge_customer
	session[:order_id] = nil
	redirect_to thanks_path
end
```
This charges the card the customer provided for the order, confirms the order (which will now appear in the admin panel), clear the current order, and redirect to a thank you page.  To be nice, let's create that view in `app/views/orders` `thanks.html.erb`
```
<h1>Thank You!</h1>
```
Now, when the customer confirms their order, they see our nice little message, and you will see an extra order in your inbox, as well as some extra money in your bank account.

That covers everything you need to know about how Kiosk works.  Happy selling!




