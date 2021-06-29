class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :admin_user, only: :destroy

  def index
    if !current_user.admin?
      flash[:danger] = t('flash.user.nopermit')
      redirect_to user_path(session[:user_id])
    end
    @users = User.includes(:tasks).order('id ASC').page(params[:page]).per(9)
  end

  def show
    if not session[:user_id]
      redirect_to root_path
    end
    @user = User.find(params[:id])
    if current_user.admin?
      @q = User.find(params[:id]).tasks.ransack(params[:q])
      @tasks = @q.result
      @tasks = @tasks.order('id ASC').page(params[:page]).per(9)
    end
  end


  def new
    if session[:user_id] && !current_user.admin?
      redirect_to user_path(session[:user_id])
    end
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t('flash.task.welcome')
      redirect_to user_path(@user)
    else
      render :new
    end
  end


  def edit
  end


  def update
    if current_user.admin?
      if @user.update(admin_params)
        flash[:success] = t('flash.user.successful-update')
        redirect_to admin_path
      else
        flash[:danger] = @user.errors.full_messages.to_sentence
        render :edit
      end
    else
      if @user.update(user_params)
        flash[:success] = t('flash.user.successful-update')
        redirect_to @user
      else
        render :edit
      end
    end
  end


  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t('flash.user.successful-delete')
    redirect_to admin_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :tel, :password, :password_confirmation)
  end

  def admin_params
    params.require(:user).permit(:name, :email, :tel, :password, :password_confirmation, :admin)
  end
  
  
  def handle_record_not_found
    flash[:notice] = t('flash.notfound')
    redirect_to :action => 'index'
  end


  # Confirm an admin user
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
