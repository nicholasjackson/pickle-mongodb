require 'cucumber/pickle_mongodb'

puts Cucumber::PickleMongoDB::pickle_steps

Mongoid.load!("features/support/mongoid.yml", :development)