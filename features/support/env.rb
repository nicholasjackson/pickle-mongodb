require 'mongoid'
require 'factory_girl'
require 'cucumber/pickle_mongodb'

puts "Version 1.1"
$SERVER_PATH = "http://localhost:3123"

Mongoid.load!("features/support/mongoid.yml", :development)