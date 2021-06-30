class LabelsController < ApplicationController
  before_action :logged_in_user
  before_action :find_label, only: [:edit, :update, :destroy]
  before_action :admin_user, only: [:edit, :update, :destroy]

  def index
    @labels = Label.includes(:tasks, :label_relations).page(params[:page]).per(9)
  end

  def show
    @label = Label.includes(:tasks, :label_relations).find(params[:id])
    @q = @label.tasks.where(user: current_user).ransack(params[:q])
    @tasks = @q.result.order('id ASC').page(params[:page]).per(9)
  end

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      flash[:success] = t('flash.label.successful-create')
      redirect_to labels_path
    else
      flash[:danger] = @label.errors.full_messages.to_sentence
    end
  end

  def edit
  end

  def update
    if @label.update(label_params)
      flash[:success] = t('flash.label.successful-update')
      redirect_to labels_path
    else
      flash[:danger] = @label.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @label.destroy if @label
    flash[:success] = t('flash.task.successful-delete')
    redirect_to labels_path
  end

  private
  def label_params
    params.require(:label).permit(:name, :color)
  end

  def find_label
    @label = Label.find(params[:id])
  end
end
