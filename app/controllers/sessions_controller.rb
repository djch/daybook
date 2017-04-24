class SessionsController < ApplicationController

  # GET /sign_in
  def new
  end

  # POST /sign_in
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      remember(@user)
      # Redirect to the user's original destination
      redirect_back_or @user
    else
      flash.now[:error] = '❌ Invalid email/password combination'
      render 'new'
    end
  end

  # POST /sign_out
  def destroy
    log_out if logged_in?
    flash[:notice] = '👋 See you again soon!'
    redirect_to root_url
  end
end
