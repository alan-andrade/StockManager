class Purchase < ActiveRecord::Base
	belongs_to :store
	belongs_to :supplier
	has_many :purchase_products, :dependent => :delete_all
	
	validates_presence_of :supplier_id
	
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
