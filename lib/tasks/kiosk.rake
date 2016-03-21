namespace :kiosk do

	desc 'Create Sample Data for Kiosk'
	task sample_data: :environment do
		require File.join(Kiosk.root, 'db', 'seeds')
	end 

	desc 'Create a default admin user'
	task create_default_user: :environment do 
		Kiosk::AdminUser.create(first_name: 'Default', last_name: 'Admin', email: 'admin@example.com', password: 'password', password_confirmation: 'password')
		puts 
		puts '		New user has been created successfully!'
		puts 
		puts '		Email address..:  admin@example.com'
		puts '		Password:......:  password'
		puts 
	end

	desc "Import States and Zip Codes"
	task import_states: :environment do 
		Kiosk::StateImporter.import
	end

	desc 'Run the esential tasks for setting up Kiosk'
	task setup: :environment do 
		Rake::Task['kiosk:create_default_user'].invoke if Kiosk::AdminUser.all.empty?
		Rake::Task['kiosk:import_states'].invoke if Kiosk::State.all.empty?
	end

end