class Customer < ActiveRecord::Base
	has_many :sales
	belongs_to :store
	
	validates_presence_of :name
end
