class TasksController < ApplicationController
    def index
        @tasks = Task.order(:id).all
        @pri_list = ['低', '中', '高', '3']
        @status_list = ['待處理', '進行中', '已完成']
    end

    def new
        @task = Task.new
    end


    def create
        @task = Task.new(task_params)

        if @task.save
            redirect_to tasks_path, notice: 'Task was successfully created'
        else
            flash[:notice] = @task.errors.full_messages.to_sentence
            render :new
        end
    end


    def edit
        @task = Task.find(params[:id])
    end


    def update
        @task = Task.find(params[:id])

        if @task.update(task_params)
            redirect_to tasks_path, notice: 'Task was successfully updated'
        else
            flash[:notice] = @task.errors.full_messages.to_sentence
            render :edit
        end
    end


    def destroy
        @task = Task.find(params[:id])
        @task.destroy if @task
        redirect_to tasks_path, notice: 'Task was successfully deleted'
    
    end
    

    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
    

    private
    def task_params
        params.require(:task).permit(:title, :content, :start, :end, :priority, :status)
    end
    
    
    def handle_record_not_found
        flash[:notice] = "Record Not Found"
        redirect_to :action => 'index'
    end
end
