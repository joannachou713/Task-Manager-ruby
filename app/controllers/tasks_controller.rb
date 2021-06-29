class TasksController < ApplicationController
  before_action :logged_in_user, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :correct_task_user, only: [:edit, :update, :destroy]

  def index
    if current_user
      @q = current_user.tasks.ransack(params[:q])
      @tasks = @q.result.includes(:labels, :label_relations)
      @tasks = @tasks.order(id: :ASC).page(params[:page]).per(9)

    else
      render :index
    end
  end
  

  def new
    @task = Task.new
    @labels = Label.all
  end


  def show
    @task = Task.find(params[:id])
  end


  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id if current_user
    params[:task_labels].each do |key, value|
      @task.labels << Label.find_by(id: key) if value == '1'
    end

    if @task.save
      flash[:success] = t('flash.task.successful-create')
      redirect_to tasks_path
    else
      flash[:danger] = @task.errors.full_messages.to_sentence
      render :new
    end
  end


  def edit
    @task = Task.find(params[:id])
    @labels = Label.all
  end


  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = t('flash.task.successful-update')
      redirect_to tasks_path
    else
      flash[:danger] = @task.errors.full_messages.to_sentence
      render :edit
    end
  end


  def destroy
    @task = Task.find(params[:id])
    @task.destroy if @task
    flash[:success] = t('flash.task.successful-delete')
    redirect_to tasks_path
  end
  

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  

  private
  def task_params
    params.require(:task).permit(:title, :content, :start, :endtime, :priority, :status, :labels)
  end
  
  
  def handle_record_not_found
    flash[:danger] = t('flash.notfound')
    redirect_to :action => 'index'
  end


  def correct_task_user
    task = Task.find(params[:id])
    user = task.user
    if user != current_user && !current_user.admin?
      flash[:danger] = t('flash.user.nopermit')
      redirect_to(root_path)
    end  
  end
end
