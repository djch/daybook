class PasswordResetsController < ApplicationController
  before_action :set_user,         only: [:edit, :update]
  before_action :validate_user,    only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  # GET /forgot_password
  def new
  end

  # POST /forgot_password
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:notice] = "📨 Okay — we've emailed you the instructions."
      redirect_to root_url
    else
      flash.now[:error] = "❌ We didn't recognise that email address, sorry."
      render 'new'
    end
  end

  # GET /password_resets/5t341thY_T0k3n-sssHhHh/email=?
  def edit
  end

  # POST/PATCH /password_resets
  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be blank")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:notice] = "👍 Welcome back! Your new password's been saved"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:password)
    end

    def set_user
      @user = User.find_by(email: params[:email])
    end

    def validate_user
      unless (@user && @user.authenticated?(:reset, params[:id]))
        flash[:error] = "❌ That password reset link was invalid"
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:error] = "⏱ Sorry your password reset link has expired"
        redirect_to new_password_reset_url
      end
    end
end
