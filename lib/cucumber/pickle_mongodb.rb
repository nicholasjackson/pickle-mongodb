require 'mongoid'
require 'factory_girl'
require 'pickle/world'
require 'rspec'
require 'cucumber/pickle_mongodb/finders.rb'

World(FactoryGirl::Syntax::Methods)

Pickle.configure do |config|
	config.adapters = [:factory_girl]
end