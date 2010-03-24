class CustomersController < ApplicationController
before_filter :find_store, :require_user

	def index
		@store = Store.find(@store_id)
		respond_to do |format|
			format.js		{	@customers = @store.customers.find(:all, :conditions => ["name LIKE ?", "%#{params[:customers_name]}%" ])}
			format.html	{	@customers = @store.customers.all(:limit=>15)}
		end	
		
	end
	
	def new
		@store = Store.find(@store_id)
		@customer = @store.customers.build
	end
	
	def create
		@store = Store.find(@store_id)
		@customer = @store.customers.build(params[:customer])
		
		if @customer.save
			flash[:notice] = "Customer created!"
			redirect_to customers_path
		else
			render :action=>:new
		end
		
	end
	
	def edit
		store = Store.find(@store_id)
		@customer = store.customers.find(params[:id])
	end
	
	def update
		@customer = Customer.find(params[:id])
		if @customer.update_attributes(params[:customer])
			flash[:notice] = "Customer updated successfully"
			redirect_to @customer
		else
			render :action=>:edit
		end
	end
	
	def show
		store = Store.find(@store_id)
		@customer = store.customers.find(params[:id], :include=>[:sales])		
	end
	
	def search
		store = Store.find(@store_id)
		name = params[:customers_name]
		@customers = store.customers.find(:all, :conditions=>["name LIKE ?", "%#{name}%"], :limit=>15)
		render :update do |page|
			page.replace_html 'customers-list', :partial=>@customers
		end
	end
	
	
end
