class UserObserver < ActiveRecord::Observer
	def before_create(user)
		UserMailer.deliver_welcome!(user)
	end
end
