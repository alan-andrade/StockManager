class Supplier < ActiveRecord::Base
	belongs_to :user
	belongs_to :store
	has_many :purchases, :dependent=>:delete_all
	
	validates_presence_of :name
end
