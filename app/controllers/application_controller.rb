class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :current_user?

  # logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # return the current logged in user (if any)
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

  # Return true if the user is logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end


   # Confirms a logged-in user.
   def logged_in_user
    unless logged_in?
       flash[:danger] = t('flash.user.login')
       redirect_to login_path
    end
  end

  # Confirms the correct user
  def correct_user
    @user = User.find(params[:id])
    redirect_to(user_path(current_user)) unless (@user == current_user || current_user.admin?)
  end

  def current_user?(user)
    user && user == current_user
  end

  # Confirm an admin user
  def admin_user
    if !current_user.admin?
      flash[:danger] = t('flash.user.nopermit')
      redirect_to(root_path)
    end
  end
end
