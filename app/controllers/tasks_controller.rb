class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end

    def new
        @task = Task.new
    end


    def create
        @task = Task.new(task_params)

        if @task.save
            redirect_to tasks_path, notice: 'Task was successfully created'
        else
            render :new
        end
    end


    def edit
        @task = Task.find_by(id: params[:id])
    end


    def update
        @task = Task.find_by(id: params[:id])

        if @task.update(task_params)
            redirect_to tasks_path, notice: 'Task was successfully updated'
        else
            render :new
        end
    end


    def destroy
        @task = Task.find_by(id: params[:id])
        @task.destroy if @task
        redirect_to tasks_path, notice: 'Task was successfully deleted'
    end


    private
    def task_params
        params.require(:task).permit(:title, :content, :start, :end, :priority, :status)
    end
end
