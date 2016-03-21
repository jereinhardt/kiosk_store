module Kiosk
  class Engine < ::Rails::Engine
    isolate_namespace Kiosk

    initializer 'kiosk.action_controller' do |app|
    	ActiveSupport.on_load :action_controller do 
    		helper Kiosk::OrdersHelper
    		# helper Kiosk::ApplicationHelper (put the necessary helper in place of 'ApplicationHelper')
    	end
    end

    initializer 'kisok.initializer' do |app|
        
    	#precompile stripe helper method
    	app.config.assets.precompile += %w( kiosk/stripe_helper.js )

              # Load our migrations into the application's db/migrate path
      unless app.root.to_s.match root.to_s
        config.paths['db/migrate'].expanded.each do |expanded_path|
          app.config.paths['db/migrate'] << expanded_path
        end
      end

    end

    # initializer :append_migrations do |app|
    #   unless app.root.to_s.match root.to_s
    #     config.paths["db/migrate"].expanded.each do |expanded_path|
    #       app.config.paths["db/migrate"] << expanded_path
    #     end
    #   end
    # end
    
  end
end
