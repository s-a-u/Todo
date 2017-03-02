class Api::TasksController < ApplicationController
  before_action :set_project
  before_action :set_task, only: [:show, :update, :destroy, :reorder]

  respond_to :json

  def show

  end

  def update
    @task.update(task_params)
    render :show
  end

  def create
    @task = @project.tasks.create(task_params)
    render :show
  end

  def destroy
    @task.destroy
    render json: {success: true}
  end

  def reorder
    @task.reorder(params[:position].to_i)
    render :show
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.permit(:description, :done)
  end
end
