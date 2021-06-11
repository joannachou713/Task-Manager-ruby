class TasksController < ApplicationController
    def index
        @tasks = Task.all.order('id')
    end
    
    
    def sort_create
        @tasks = Task.all.order('created_at ASC')
        render template: "tasks/index.html.erb"
    end
    
    
    def sort_priority
        @tasks = Task.all.order('priority DESC')
        render template: "tasks/index.html.erb"
    end


    def sort_status
        @tasks = Task.all.order('status ASC')
        render template: "tasks/index.html.erb"
    end


    def new
        @task = Task.new
    end


    def create
        @task = Task.new(task_params)

        if @task.save
            redirect_to tasks_path, notice: I18n.t('successful-create')
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
        params.require(:task).permit(:title, :content, :start, :end, :priority, :status)
    end
    
    
    def handle_record_not_found
        flash[:notice] = "Record Not Found"
        redirect_to :action => 'index'
    end
end
