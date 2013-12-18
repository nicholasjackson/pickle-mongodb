require 'mongoid'
require 'factory_girl'
require 'pickle/world'
require 'rspec'
require 'cucumber/pickle_mongodb/finders.rb'
require 'cucumber/pickle_mongodb/version.rb'

module Cucumber
	module PickleMongoDB
		def self.pickle_steps
      		t = ["#{File.dirname(File.expand_path($0))}/../lib/#{FOLDER}",
           	"#{Gem.dir}/gems/#{NAME}-#{VERSION}/lib/#{FOLDER}"]
      		t.each {|i| return "#{i}/pickle_steps.rb" if File.readable?(i) }
      		raise "both paths are invalid: #{t}"
    	end
    end
end

World(FactoryGirl::Syntax::Methods)

Pickle.configure do |config|
	config.adapters = [:factory_girl]
end