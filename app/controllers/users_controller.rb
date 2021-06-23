class UsersController < ApplicationController


  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
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
