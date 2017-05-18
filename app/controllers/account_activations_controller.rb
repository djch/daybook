class AccountActivationsController < ApplicationController

  # GET /account_activations/abcdefghijklmnopqrstuvwxyz0123456789/email=?
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:notice] = "🙌 Your account's been activated — welcome aboard!"
      redirect_to user
    else
      flash[:notice] = "❌ That activation link is invalid — sorry!"
      redirect_to root_url
    end
  end
end
