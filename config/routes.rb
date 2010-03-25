ActionController::Routing::Routes.draw do |map|

	map.resources :stores, :products, :suppliers, :purchases, :customers
	map.resources :sales, :member=>{
		:statistics => :get
	}	
	map.resource :user_session
	map.resource :account, :controller=>:users
	map.resources :users
	map.with_options :controller=>:information do |info|
		info.about		'about'		, :action=>:about
		info.faq			'faq'			,	:action=>:faq
		info.contact	'contact'	, :action=>:contact
		info.pricing	'pricing'	,	:action=>:pricing
	end
	map.resources :stock_products
	map.myproducts 'myproducts', :controller=>:stock_products, :action=>:index
	map.root :controller=>:information, :action=>:about
	map.logout 'logout', :controller=>:user_sessions, :action=>:destroy
	
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
