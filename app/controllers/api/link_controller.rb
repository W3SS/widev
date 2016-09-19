class Api::LinkController < ApplicationController
  def getByEnvironemnt
    @links = Link.where(:environment_id => params[:env_id])
    render json: @links
  end
end
