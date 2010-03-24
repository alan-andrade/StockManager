module SalesHelper

	def date_to_js(record)
		"new Date(#{record.created_at.year}, #{record.created_at.month}, #{record.created_at.day})"
	end
	
  def to_google_graph(sales, purchases)
  	combine = [] << sales << purchases; combine.flatten!
  	start_date = (combine.min{|s, t| s.created_at <=> t.created_at}).created_at.to_date
  	end_date		=	(combine.max{|s, t| s.created_at <=> t.created_at} ).created_at.to_date
  	daterange = start_date-3.day..end_date+3.day; combine = nil;
  	
  	for date in daterange
		 	sales_match 		= sales.find_all{|s| s.created_at.to_date == date}
			purchases_match	= purchases.find_all{|p| p.created_at.to_date == date} 
		
			string = '[' +
			"new Date(#{date.year}, #{date.month-1}, #{date.day}), " +
			" #{sales_match.size}," +
			" #{purchases_match.size},"	+
			'], '
			
			concat string
  	end
   end
end
