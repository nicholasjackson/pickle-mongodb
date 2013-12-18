#pickle-mongodb


##Description
***

Pickle is an excellent framework developed by Ian White which allows you to create models from factory-girl, machinist, or fabrication. Pickle can make use of different ORMs for finding records. Currently ActiveRecord, DataMapper, MongoID adapters are provided.

Pickle-MongoDB is a convenience Gem which packages up pickle and decouples it from rails to allow you to do database CRUD (Create, Read, Update, Delete) on a Mongo DB instance from your BDD cucumber steps.  

We developed this as we wanted a simple method of preparing and checking data in our datastore as part of our functional tests for APIs.  Used in combination with [Cucumber-Rest-API](https://github.com/DigitalInnovation/cucumber_rest_api) you can easily write feature based functional tests for your Rest APIs.  

Pickle MongoDB brings together [Pickle](https://github.com/DigitalInnovation/cucumber_rest_api), [Factory-Girl](https://github.com/thoughtbot/factory_girl) and [Mongoid](http://mongoid.org/en/mongoid/index.html) in one handy package.

By simply configuring your database connection and setting up your Factory-Girl models you can create and interrogate database entities right from your cucumber features.


##Use  
***

The features folder in this repo has an example setup however using Pickle-MongoDB is easy to set up and use.

###Step 1
Reference the pickle-mongodb gem in your Gemfile

```ruby     
source 'https://rubygems.org'

gem 'cucumber', '~> 1.3.10'  
gem 'pickle', '~> 0.4.11'    
gem 'mongoid', '~> 3.1.6'  
gem 'rspec', '~> 2.14.1'  
gem 'factory_girl', '~> 4.3.0'  
gem 'pickle-mongodb', '~> 0.1'
``` 

###Step 2 create your features folder   
Create your features folders with the following structure  
```
--features  
  |  
   --step_definitions  
     |  
      --mystep_file.rb  
   --support  
     |  
      --01_launch.rb
      --env.rb  
      --models.rb  
      --mongoid.yaml    
   myfeature.feature
```

###Setup your environment
Most of the work setting up the environment with Pickle and configuring the Factory-Girl adaptor is already done for you however you do need to set up the database connection and reference the main pickle-mongo gem.  I recommend you do this in your **env.rb** file however if you have multiple databases under test you may want to do this in your before scenario setup.   

```ruby
require 'cucumber/pickle_mongodb'

Mongoid.load!('features/support/mongoid.yml', :development)
```   

The mongoid.yml file contains your database connection file, a simple example will look something like this  

```yaml
development:  
  sessions:  
    default:  
      database: mongoid   
      hosts:   
        - localhost:27017   
```

The final thing you have to do is include the default pickle steps into your steps, at present you must include thes in either a blank step file in your **step_definitions** folder or at the top of any existing step definitions file.

```ruby   
require 'cucumber/pickle_mongodb/pickle_steps.rb'
```

###Defining your models
The next step is to define your models that pickle will use, these are created with Factory-Girl and must be referenceable by cucumber, personnaly I find the support folder is a good place to put these.  

Lets look at a Person model, first we define the MongoID document like so...
```ruby
class Person
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
end
```

Then we create a factory-girl model which references this like so...
```ruby
FactoryGirl.define do
  factory :admin, class: Person do
    first_name "Admin"
    last_name  "User"
  end
end
```

The beauty of using factory-girl is that you can create models that implement default properties, of course pickle will allow you to overide these but for convenience you can reference admin who is of type Person in your feature, this keeps your Gerkin nice and clean, because of this you can also create multiple models which share the same type, consider the following...   
```ruby
FactoryGirl.define do
  factory :fred, class: Person do
    first_name     "Fred"
    last_name      "Jones"
    address_line_1 "186 Freds Street"
  end
  factory :jane, class: Person do
    first_name     "Jane"
    last_name      "Maclain"
    address_line_1 "186 Janes Road"
  end
end
```

These models would be referenced in the default steps like so....
```cucumber
Given jane exists  
Given fred exists  
Given jane exists with last_name: "Jones"  
Then a jane should exist  
Then a admin should exist with last_name: "Jones"  
```

##Default Steps

###Given steps

"Given <b>a model</b> exists",  e.g.
```
  Given a user exists   
  Given a user: "fred" exists   
  Given the user exists   
```   
"Given <b>a model</b> exists with <b>fields</b>",  e.g.
```
  Given a user exists with name: "Fred"  
  Given a user exists with name: "Fred", activated: false  
```  
This last step could be better expressed by using Machinist/FactoryGirl to create an activated user.  Then you can do
```
  Given an activated user exists with name: "Fred"
```
You can refer to other models in the fields
```
  Given a user exists   
  And a post exists with author: the user   

  Given a person "fred" exists   
  And a person "ethel" exists   
  And a fatherhood exists with parent: person "fred", child: person "ethel"
```  
This last step is given by the default pickle steps, but it would be better written as:
```
  And "fred" is the father of "ethel"
```  
It is expected that you'll need to expand upon the default pickle steps to make your features readable.  To write the 
above step, you could do something like:
```
  Given /^"(\w+)" is the father of "(\w+)"$/ do |father, child|   
    Fatherhood.create! :father => model!("person: \"#{father}\""), :child => model!("person: \"#{child}\"")   
  end 
```
"Given <b>n models</b> exist", e.g.
```
  Given 10 users exist
```

"Given <b>n models</b> exist with <b>fields</b>", examples:
```
  Given 10 users exist with activated: false
```
"Given the following <b>models</b> exist:", examples:
```
  Given the following users exist
    | name  | activated |
    | Fred  | false     |
    | Ethel | true      |
```

###Regexps for use in your own steps

By default you get some regexps available in the main namespace for use
in creating your own steps: `capture_model`, `capture_fields`, and others (see lib/pickle.rb)

(You can use any of the regexps that Pickle uses by using the Pickle.parser namespace, see
Pickle::Parser::Matchers for the methods available)

**capture_model**
```
  Given /^#{capture_model} exists$/ do |model_name|  
    model(model_name).should_not == nil  
  end  

  Then /^I should be at the (.*?) page$/ |page|  
    if page =~ /#{capture_model}'s/  
      url_for(model($1))  
    else  
      # ...  
    end  
  end  

  Then /^#{capture_model} should be one of #{capture_model}'s posts$/ do |post, forum|  
    post = model!(post)  
    forum = model!(forum)  
    forum.posts.should include(post)  
  end  
```
**capture_fields**

This is useful for setting attributes, and knows about pickle model names so that you
can build up composite objects with ease
```
  Given /^#{capture_model} exists with #{capture_fields}$/ do |model_name, fields|   
    create_model(model_name, fields)   
  end   

  # example of use  
  Given a user exists  
  And a post exists with author: the user # this step will assign the above user as :author on the post   
```