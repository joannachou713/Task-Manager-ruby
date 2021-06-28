class TasksController < ApplicationController
  before_action :logged_in_user, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :correct_task_user, only: [:new, :create, :edit, :update, :destroy]

  def index
    if current_user
      @q = Task.where(user_id: current_user.id).ransack(params[:q])
      @tasks = @q.result
      @tasks = @tasks.order('id ASC').page(params[:page]).per(9)
    else
      render :index
    end
  end
  

  def new
    @task = Task.new
  end


  def show
    @task = Task.find(params[:id])
  end


  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id if current_user

    if @task.save
      redirect_to tasks_path, notice: I18n.t('successful-create')
    else
      flash[:danger] = @task.errors.full_messages.to_sentence
      render :new
    end
  end


  def edit
    @task = Task.find(params[:id])
  end


  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      redirect_to tasks_path, notice: I18n.t('successful-update')
    else
      flash[:notice] = @task.errors.full_messages.to_sentence
      render :edit
    end
  end


  def destroy
    @task = Task.find(params[:id])
    @task.destroy if @task
    redirect_to tasks_path, notice: I18n.t('successful-delete')
  end
  

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  

  private
  def task_params
    params.require(:task).permit(:title, :content, :start, :endtime, :priority, :status)
  end
  
  
  def handle_record_not_found
    flash[:notice] = "Record Not Found"
    redirect_to :action => 'index'
  end


  def correct_task_user
    task = Task.find(params[:id])
    user = task.user_id
    flash[:danger] = "權限不足"
    redirect_to(user_path(current_user)) unless user == current_user 
  end
end
