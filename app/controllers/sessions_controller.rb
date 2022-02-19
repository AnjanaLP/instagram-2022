class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to user
    else
      flash.now[:error] = "Sorry, your email or password was incorrect"
      render 'new', status: :unprocessable_entity
    end
  end
end