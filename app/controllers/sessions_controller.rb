class SessionsController < ApplicationController
  def new
  
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		redirect_to user_url(user)
      log_in(user)
  	else
  	
  	flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
  	render 'new'
  	end

  end

  def destroy
  	
  end
end
