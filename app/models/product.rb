class Product < ActiveRecord::Base
	has_one :stock_product, :dependent=>:delete, :validate=>true
	has_many :sale_products
	
	validates_presence_of :product_name, :price
	validates_numericality_of :price, :greater_than => 0
	
	delegate :store, :to => :stock_product

	before_save {|p| p.product_name.capitalize!}

end
