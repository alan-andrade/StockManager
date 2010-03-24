class UserMailer < ActionMailer::Base
	def low_stock(user, product)
		recipients	user.email
		from				'admin@stockmanager.com'
		subject			'You have a low stock product !'
		body				:product => product, :user => user
	end  
	
	def welcome(user)
		recipients 	user.email
		from				'admin@stockmanager.com'
		subject			'Welcome to Stock Manager!'
		body				:user => user
	end
end
