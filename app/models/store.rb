class Store < ActiveRecord::Base

	def to_param
		"#{id}-#{store_name}"
	end
	
	#---- SALES -----#
	has_many :sales, 	:dependent 	=> 	:delete_all
	has_many :month_sales	, :class_name => 	'Sale'	,	:conditions => 	["created_at < ? AND created_at >= ?", Time.now.end_of_month, Time.now.beginning_of_month] 
	has_many :year_sales	, :class_name	=>	'Sale'	,	:conditions	=>	["created_at < ? AND created_at >= ?", Time.now.end_of_year, Time.now.beginning_of_year]
	## END ##
	
	
	#---- PURCHASES ----#	
	has_many :purchases, :dependent => :delete_all
	has_many :month_purchases	,	:class_name	=>	'Purchase'	,	:conditions	=> 	["created_at < ? AND created_at > ?", Time.now.end_of_month, Time.now.beginning_of_month]
	has_many :year_purchases	,	:class_name	=>	'Purchase'	,	:conditions	=>	["created_at < ? AND created_at > ?", Time.now.end_of_year, Time.now.beginning_of_year]	
	## PURCHASES ##
	
	belongs_to :user
	has_one :stock, 	:dependent	=> 	:delete
	has_many :suppliers
	has_many :customers	
	
	attr_protected :user_id
	
	validates_presence_of :store_name

	delegate :stock_products, :active_products, :to=>:stock
	
	def name
		store_name
	end

end
