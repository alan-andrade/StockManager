class Sale < ActiveRecord::Base
	belongs_to :store
	belongs_to :customer, :autosave=>true
	
	has_many :sale_products, :include => :product, :dependent => :destroy
	
	has_one :user, :through=>:store ## Just by playing around with assosiations.
		
	accepts_nested_attributes_for :sale_products
	accepts_nested_attributes_for :customer
	
	attr_protected :store_id	
	
	def day
		created_at.to_date.day
	end
	
	def month
		created_at.to_date.month
	end
	
	def date
		created_at.to_date
	end

end
