class Person
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
end

class Dog
	include Mongoid::Document

	field :food, type: String
 end


FactoryGirl.define do
	factory :admin, class: Person do
		first_name "Admin"
		last_name  "User"
	end

	factory :bigdog, class: Dog do
		food "Bacon"
	end
end