require 'mongoid'

 # Overide the implementation of first defined in the Mongoid finders
 # to implement the new v3 API find method
 module Mongoid
 	module Finders
    extend Origin::Forwardable
	    def first(fields)
	  		find_by(fields[:conditions]) #returns the first instance matching given criteria
	  	end

      def all(fields)
	  		where(fields[:conditions]) #returns the first instance matching given criteria
	  	end
	 end
end
