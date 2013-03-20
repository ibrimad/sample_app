module SessionsHelper

	# This store the user’s remember token in a cookie for later use.
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end
	
	#This line just sets an instance variable @current_user, effectively storing the user for later use.
	def current_user=(user)
		@current_user = user
	end		

	# Finding the current user using the remember_token.]
	# Ruby pattern [||= or equals]  is assigning to a variable if it’s nil but otherwise leave it alone.

	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	def current_user?(user)
		user == current_user
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	#This evaluates to session[:return_to] unless it’s nil, in which case it evaluates to the given default URI.

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)	
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url
	end		

end
