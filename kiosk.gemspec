$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "kiosk/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "kiosk"
  s.version     = Kiosk::VERSION
  s.authors     = ["Josh Reinhardt"]
  s.email       = ["joshua.e.reinhardt@gmail.com"]
  s.homepage    = "http://www.joshuaereinhardt.com"
  s.summary     = "A simple ecommecre engine for small online stores."
  s.description = "Kiosk is an ecommecre engine that values simplicity above all else."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.2"
  s.add_dependency "paperclip", "~> 4.3"
  s.add_dependency "jquery-rails", '~> 4.1'
  s.add_dependency 'bcrypt', '>= 3.1.2'
  s.add_dependency "stripe"

  s.add_development_dependency "sqlite3"
end
