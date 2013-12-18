#require 'cucumber/pickle_mongodb/pickle_steps.rb'

Before do |scenario|
	Mongoid.purge! #Clear the mongo database before the tests	
end

After do |scenario|
  
end

at_exit do
  
end
