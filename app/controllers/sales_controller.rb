class SalesController < ApplicationController
	before_filter :require_user
	before_filter :find_store

	def new
		@sale = @store.sales.build
		@products_names = @store.stock_products.find(:all, :select => "product_name, product_id", :joins=>:product, :conditions=>["qty > ? AND active = true", 0])
		@customer = @sale.build_customer
	end
	
	def create
		@sale = @store.sales.build(params[:sale])
		@sale.customer.store = @store if @sale.customer
		@sale.customer = @store.customers.find_by_name(params[:customers_name]) if params[:customers_name]
		@sale.sale_products.build(params[:sale_products_attributes])
		
		if @sale.save
			flash[:notice] = "Sale Made!"
			redirect_to @sale
		else
			flash[:error] = "Oops, try again."
			redirect_to :action=>:new
		end		
	end
	
	def show
		@sale = @store.sales.find(params[:id], :include=>[:sale_products, :store, :customer] )
	end
	
	def index
		#@sales = @store.sales.all(:include => [:sale_products, :customer], :limit=>30)
		@sales = @store.sales.paginate(:page => params[:page], :per_page=>10, :order=>"created_at DESC", :include => [:sale_products, :customer])
	end
	
	def destroy
		@sale = @store.sales.find(params[:id])
		if @sale.destroy
			expire_page :action => :statistics
			flash[:notice] = "Sale Canceled"
			redirect_to sales_path()
		else
			render :update do |page|
				page << "alert('Something went wrong. We are working in it...')"
			end
		end		
	end
	
	def statistics
		@sales = @store.year_sales
		@purchases = @store.year_purchases.all
		render :layout => 'stats'
	end
end
