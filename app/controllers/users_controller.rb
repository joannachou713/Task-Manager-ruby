class UsersController < ApplicationController


  def show
    if not session[:user_id]
      redirect_to root_path
    end
    @user = User.find(params[:id])
  end

  def new
    if session[:user_id]
      redirect_to user_path(session[:user_id])
    end
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to Task Manager!'
      redirect_to user_path(@user)
    else
      render :new
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :tel, :password, :password_confirmation)
  end
  
  
  def handle_record_not_found
    flash[:notice] = "Record Not Found"
    redirect_to :action => 'index'
  end
end
