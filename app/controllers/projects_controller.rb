class ProjectsController < ApplicationController
  respond_to :html, :json

  def index
    projects = Project.all
    respond_with(projects)
  end

  def create
    respond_with Project.create(project_params)
  end

  def show
    respond_with Project.find(params[:id])
  end

  def update
    project = Project.find(params[:id])
    project.update_attributes(project_params)
    respond_with project
  end

  def upload_files
    project = Project.find(params[:id])
    image = project.images.build
    image.attachment = params[:file]
    image.save!
    render json: ImageSerializer.new(image)
  end

  private
  def project_params
    params.require(:project).permit(:name)
  end

end
