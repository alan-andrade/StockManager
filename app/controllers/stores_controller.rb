class StoresController < ApplicationController
	before_filter :require_user
	before_filter :find_store, :only=>[:show, :new_product]
	
	def new		
		@store = @current_user.stores.new
		render :layout => 'application'
	end
	
	def create
		@store = @current_user.stores.build(params[:store])		
		@store.build_stock
		if @store.save
			flash[:notice] = "! Congratulations ! #{@store.store_name} store was created succesfully! ."
			redirect_to store_path @store.id
		else
			render :new
		end
	end
	
	def show
		@store = @current_user.stores.find(params[:id], :include=>:suppliers) 
		@store_products_qty = @store.stock.stock_products.count(:conditions => "active = 1")
		@last_sale = @store.sales.last
		@low_stock_products = @store.stock.stock_products.count(:joins=>:product, :conditions => ["qty < ?", 5])
		@last_month_sales = @store.sales.count(:conditions => ["created_at < ? AND created_at > ?", Time.now.end_of_month, Time.now.beginning_of_month])
		@stock_product = @store.stock_products.build
		@product = @stock_product.build_product
		@purchases_this_month = @store.purchases.count(:conditions => ["created_at < ? AND created_at > ?", Time.now.end_of_month, Time.now.beginning_of_month])
		@customersqty = @store.customers.count
	end
	
	def edit
	end
	
	def update		
	end
	
	def destroy
		@store = @current_user.stores.find(params[:id])
		if @store.delete			
			respond_to do |format|
				format.html do
					flash[:notice] = "#{@store.store_name} store deleted."
					redirect_to @current_user
				end
				format.js{render :nothing => true}
			end
		end
	end
	
	def new_product
		@stock_product = Store.find(@store_id).stock.stock_products.build
		@product = @stock_product.build_product
		respond_to do |format|
			format.js do
				render :update do |page|
					page.replace_html 'new-product-form', :partial=>'new_product_form', :locals=>{:sp => @stock_product, :product=> @product}
				end
			end
		end		
	end	
end
