class SessionsController < ApplicationController
  def new
    if session[:user_id]
      redirect_to user_path(session[:user_id])
    end
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      if params[:session][:remember_me] == '1'
        remember user
      else
        forget user
      end
      flash[:success] = t('flash.task.welcome')
      redirect_to root_path
    else
      flash.now[:danger] = t('flash.user.failed')
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
