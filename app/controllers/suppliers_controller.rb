class SuppliersController < ApplicationController
	before_filter :require_user, :find_store
	
	def index
		@suppliers = @current_user.suppliers(:include=>:store)		## Check out optimization
	end
	
	def new
		@supplier = Supplier.new
	end
	
	def create
		@supplier = @current_user.suppliers.build(params[:supplier])
		@supplier.store = Store.find(@store_id)
		if @supplier.save
			flash[:notice] = "Supplier Created!"
			redirect_to @supplier.store
		else
			render :action=>:new
		end
	end
	
	def show
		@sup = Supplier.find(params[:id], :include=>:store)
	end
	
	def edit
		@supplier = Supplier.find(params[:id], :include => :store)
		@stores = @current_user.stores
	end
	
	def update
		@supplier = Supplier.find(params[:id])
		if @supplier.update_attributes(params[:supplier])
			flash[:notice] = "Supplier Edited Succesfully"
			redirect_to @supplier
		else
			render :action=>:edit
		end
	end
	
end
