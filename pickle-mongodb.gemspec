# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cucumber/pickle_mongodb/version"

Gem::Specification.new do |s|
  s.name        = Cucumber::PickleMongoDB::NAME
  s.version     = Cucumber::PickleMongoDB::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nic Jackson"]
  s.email       = ["jackson.nic@gmail.com"]
  s.homepage    = "https://github.com/nicholasjackson/pickle-mongodb"
  s.summary     = %q{Cucumber steps to easily integrate pickle with MongoDB}
  s.description = %q{Pickle MongoDB allows you to write BDD steps to interact with your MongoDB database, you can create and interrogate the database using the handy built in steps}

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency              'cucumber',  '>= 1.2.1'
  s.add_dependency              'rspec',  '>= 2.12.0'
  s.add_dependency              'pickle', '~> 0.4.11'
  s.add_dependency              'mongoid', '~> 3.1.6'
  s.add_dependency              'factory_girl', '~> 4.3.0'

  s.files = ["lib/cucumber/pickle_mongodb.rb","lib/cucumber/pickle_mongodb/finders.rb","lib/cucumber/pickle_mongodb/pickle_steps.rb","lib/cucumber/pickle_mongodb/version.rb"]
  s.license = 'MIT'
end
