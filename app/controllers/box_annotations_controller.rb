class BoxAnnotationsController < ApplicationController
  respond_to :json

  def create
    image = Project.find(params[:box_annotation][:project_id]).images.find(params[:box_annotation][:image_id])
    box_annotation = image.box_annotations.create(box_annotation_params)
    respond_with box_annotation
  end

  def update
    image = Project.find(params[:box_annotation][:project_id]).images.find(params[:box_annotation][:image_id])
    box_annotation = image.box_annotations.find(params[:id])
    box_annotation.update_attributes(box_annotation_params)
    respond_with box_annotation
  end

  private

  def box_annotation_params
    params.require(:box_annotation).permit(:x, :y, :width, :height)
  end

end
