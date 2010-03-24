class ProductsController < ApplicationController
	before_filter :require_user, :except=>:for_selection
	before_filter :find_store, :except=>:for_selection
	
	def edit
		@product = Product.find(params[:id])
	end
	
	def show
		@product = Product.find(params[:id], :include => :stock_product)
	end
	
	def update
		@product = Product.find(params[:id])
		if @product.update_attributes(params[:product])
			flash[:notice] = "Succesfully Updated"
			redirect_to @product
		end
	end
	
	def destroy
		@product = Product.find(params[:id])
		if @product.update_attribute(:active, false)
			respond_to do |format|
				format.js do 
					render :update do |page|
					 page[@product].visual_effect 'SlideUp', :duration=>'0.5'
					end
				end
				format.html{redirect_to myproducts_path}
			end
		end
	end
	
	def for_selection
		store_id = params[:id]
		@products ||= Store.find(store_id).stock_products.map{|a| a.product } unless store_id.nil?
		if request.xhr?
			render :json => @products
		end
	end
	
end
