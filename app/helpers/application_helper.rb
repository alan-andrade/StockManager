# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def hide_flash_js(key_of_flash)
		javascript_tag "hide_flash_messages('#{key_of_flash}');"
	end
	
	def hidden_div_if(condition, attrs={},&block)
		unless condition
			attrs[:style] = "display:none"
		end
		content_tag(:div, attrs, &block)
	end	
	
	def btm
		link_to "Back to Main", store_path(find_store)
	end
	
  def daysIn(monthNum)
     (Date.new(Time.now.year,12,31).to_date<<(12-monthNum)).day
  end 
   
end
