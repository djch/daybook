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
    elsif
      @user && !@user.authenticate(params[:session][:password])
      flash.now[:error] = "❌ We didn't recognise that password. \
                           If you've forgotten, you can #{view_context.link_to("reset it here", forgot_password_path)}".html_safe
      render 'new'
    else
      flash.now[:error] = "❌ We didn't recognise that email, sorry"
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
