class Api::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @projects = current_user.projects.includes(:tasks)
  end

  def show

  end

  def update
    @project.update(project_params)
    render :show
  end

  def create
    @project = current_user.projects.create(project_params)
    render :show
  end

  def destroy
    @project.destroy
    render json: {success: true}
  end

  private

    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.permit(:name)
    end
end
