class SessionsController < ApplicationController

  def new
  end

  # Sign in
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      remember(@user)
      redirect_to @user
    else
      flash.now[:error] = '❌ Invalid email/password combination'
      render 'new'
    end
  end

  # Sign out
  def destroy
    log_out if logged_in?
    flash[:notice] = '👋 See you again soon!'
    redirect_to root_url
  end
end
