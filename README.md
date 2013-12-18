#pickle-mongodb


##Description
***

Pickle is an excellent framework developed by Ian White which allows you to create models from factory-girl, machinist, or fabrication. Pickle can make use of different ORMs for finding records. Currently ActiveRecord, DataMapper, MongoID adapters are provided.

Pickle-MongoDB is a convenience Gem which packages up pickle and decouples it from rails to allow you to do database CRUD (Create, Read, Update, Delete) on a Mongo DB instance from your BDD cucumber steps.  

We developed this as we wanted a simple method of preparing and checking data in our datastore as part of our functional tests for APIs.  Used in combination with [Cucumber-Rest-API](https://github.com/DigitalInnovation/cucumber_rest_api) you can easily write feature based functional tests for your Rest APIs.  


##Use  
***

The features folder in this repo has an example setup however using Pickle-MongoDB is easy to set up and use.

###Step 1
Reference the pickle-mongodb gem in your gemfile

```  
source 'https://rubygems.org'

gem 'cucumber', '~> 1.3.10'  
gem 'pickle", '~> 0.4.11'    
gem 'mongoid", '~> 3.1.6'  
gem 'rspec", '~> 2.14.1'  
gem 'factory_girl', '~> 4.3.0'  
``` 