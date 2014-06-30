class ProjectsController < ApplicationController
  respond_to :html, :json

  def index
    @projects = Project.all

    respond_with(@projects)
  end

  def show
    @project = Project.find(params[:id])

    respond_with @project
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(params[:project])
    @project.save

    respond_with @project
  end

  def update
    @project = Project.find(params[:id])
    @project.assign_attributes(params[:project])
    @project.save

    respond_with @project
  end

  def upload_files
    @project = Project.find(params[:id])
    image = @project.images.build
    image.attachment = params[:file]
    image.save!
    render json: ImageSerializer.new(image)
  end

end
