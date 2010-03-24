module StoresHelper
	def add_link
		link_to_remote "Add", :url=>{:action=>'new_product', :id=>params[:id]},											
												:success=>"$('loading').hide()",
												:complete => (update_page do |page|													
													page['new-product-form'].visual_effect "SlideDown", :duration=>"0.5"																										
													page.delay(0.6) do
														page << "window.scroll(0,150);"
														page << "$('product_name').focus();"														
													end
												end),
												:failure => "alert('Something went wrong.');$('add-product-button').show();",
												:before => "$('add-product-button').hide();$('loading').show()",
												:html=>{:title=>"Add products to your store!"}
	end
end
