# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password, :password_confirmation
  
  helper_method :current_user, :current_user_session, :find_store
  
  before_filter :set_locale
  
  def set_locale
  	I18n.locale = extract_local_from_uri
  end
  
  def extract_local_from_uri
  	parsed_locale = request.subdomains.first  	
  	(LOCALES.include? parsed_locale) ? parsed_locale : nil
  end
  
  private
  	def current_user_session
  		return @current_user_session if defined?(@current_user_session)
       @current_user_session = UserSession.find
  	end
  	
  	def current_user
  		return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
  	end
  	
  	def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end
 
    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
    
    def find_store
			session[:store_id] = params[:id] if (params[:id] and controller_name == 'stores')
			@store_id = session[:store_id]
			@store = Store.find(@store_id)
		end
  
end
