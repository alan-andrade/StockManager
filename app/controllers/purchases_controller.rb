class PurchasesController < ApplicationController
	before_filter :find_store, :require_user
	
	def index
		@store = Store.find(@store_id)
		@purchases = @store.purchases.find(:all, :include=>[:supplier, :purchase_products=>[:product]], :order => 'created_at DESC')
	end
	
	def new
		@purchase = Purchase.new
		@store = Store.find(@store_id, :include => [:suppliers, :stock =>:stock_products ]) #We include all the associations to use.
		if @store.suppliers.empty? 
			flash[:error] = "You need to add your suppliers!"
			redirect_to new_supplier_path
		end
	end
	
	def create
		@purchase = Store.find(@store_id).purchases.build(params[:purchase])
		@purchase.purchase_products.build(params[:purchase_products]) #Got to build this way cause accepts_nested_attributes_for complicate things up.
		if @purchase.save
			flash[:notice] = "Purchase Complete"
			redirect_to purchases_path
		else
			flash[:error] = "Purchase Error"
			redirect_to :action=>:new
		end
	end
	
	def show
		@purchase = Store.find(@store_id).purchases.find(params[:id], :include=>[:supplier, :purchase_products=>[:product]])
	end
end
