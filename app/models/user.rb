class User < ActiveRecord::Base
	acts_as_authentic
	
	has_many :stores, :dependent=>:delete_all
	has_many :suppliers, :dependent=>:delete_all

end
