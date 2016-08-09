class MyEnvironmentController < ApplicationController
      before_action :authenticate_user!

  def status
    @env = Environment.find(params[:env_id])
    
    @installations = Installation.where(is_started:true).where("is_done is null").where(environment_id: @env.id).order(created_at: :desc)
    @oldinstall = Installation.where(is_done:true).where(environment_id: @env.id).order(created_at: :desc).limit(200)
    
  end

  def history
  end

  def info
  end
  
  
  def home
    @environments = Environment.all
  end
end
