module SessionsHelper

  # Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Forgets a user's persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Returns the currently logged-in user
  # If there's no user in the temporary session we check for a permanent
  # session in the cookies and log them in if one exists.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the given user is the currently logged in user
  def current_user?(user)
    user == current_user
  end

  # Returns true if the user is logged in
  def logged_in?
    !current_user.nil?
  end

  # Logs the current user out
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Stores the destination URL originally requested
  def store_destination
    session[:forwarding_url] = request.original_url if request.get?
  end

  # Redirect to a stored URL or fall back to a default
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
end
