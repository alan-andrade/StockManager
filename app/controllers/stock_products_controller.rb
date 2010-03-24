class StockProductsController < ApplicationController
	before_filter :find_store, :require_user, :except=>:show
	
	def index
		@store 		= @current_user.stores.find(@store_id)
		#@stock_products = @store.stock_products.all(:limit=>10, :include => :product, :joins=>:product, :conditions=>["active = ?", true])
		@stock_products = @store.active_products.all(:limit=>10, :order=>"qty") 
	end
	
	def show
#		@product ||= StockProduct.find_by_sql("SELECT qty FROM stock_products_join WHERE product_id = #{params[:id]}")
		@product = StockProduct.find(:first, :conditions=>["product_id = ?", params[:id]])
		if request.xhr?
				render :json => @product
		else
			redirect_to account_path
		end
	end
	
	def create
		store = @current_user.stores.find(@store_id)
		stock = store.stock		
		@stock_product = stock.stock_products.build(params[:stock_product])
		@product = @stock_product.build_product(params[:product])
		
		if @stock_product.save
			render :update do |page|
				page.call 'cleanForm'
				page.call 'updateProductsCounter'				
			end
		else
			render :update do |page|
				page.replace_html 'form-errors', :partial => 'form_validation_errors', :locals=>{:product => @product, :stock_product=>@stock_product}
				page['form-errors'].show
			end
		end		
	end
	
	def search
		name = params[:product_name]
		@store = Store.find(@store_id)
		#@stock_products = @store.stock_products.all(:limit=>10, :conditions=>["product_name LIKE ? AND active = ?", "%#{name}%", true], :joins => :product, :include => :product)
		@stock_products = @store.active_products.all(:limit=>10, :conditions=>["product_name LIKE ?", "%#{name}%"])
		#@products = Product.find_by_sql("Select * From stock_products_join sp where stock_id = #{@store.stock.id} AND name LIKE '%#{name}%' LIMIT 20" )
		#@products.each{|p| p.qty = p.stock_product.qty }
		render :update do |page|
			page.replace_html 'listing-products', :partial => @stock_products unless @stock_products.empty?
			page.replace_html 'listing-products', :text=>"<p>No results were found. Try again.</p>" if @stock_products.empty?
		end
	end
end
