class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update, :index, :destroy, :show]
  before_action :require_ownership, only: [:edit, :update, :destroy]

  # GET /users (paginated with geared_pagination)
  def index
    set_page_and_extract_portion_from User.order(created_at: :desc)
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /sign_up
  def new
    @user = User.new
  end

  # POST /sign_up
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:notice] = "📧 Almost there! Check your email for an activation link."
      redirect_to root_url
    else
      render 'new'
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PATCH/PUT /users/1/edit
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "✔︎ Your profile was updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "✔︎ The user's account was deleted"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    # Ensure a user is signed in first
    def require_login
      unless logged_in?
        store_destination
        flash[:notice] = "Enter your email + password and we'll get you right back in to Day Book"
        redirect_to sign_in_url
      end
    end

    # Ensure particular actions can only be performed by the owner OR an admin
    def require_ownership
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user) || current_user.admin?
    end
  end
