class MyInstallationController < ApplicationController
    before_action :authenticate_user!

  def newinstall
    @installation = Installation.new

    if params[:release_id] != nil
      @installation.save!

      release = Release.find(params[:release_id])
      release.installation = @installation
      release.save!

      @installation.release = release.system.short+"-"+release.rel
      @installation.save!

      render :newinstall_byrel
    end

  end
  
  def createinstall
    
    @installation = Installation.new(installation_params)
    @installation.is_started=true
    @installation.save!

    @template = RelTemplate.find(@installation.rel_template_id)

    @template.rel_template_item.each() do |i|
      @installation.item_per_installation.create(rel_template_item_id:i.id)
    end
    
    redirect_to '/my_installation/viewinstall/'+@installation.id.to_s
    
  end

    def update

      @new_installation = Installation.find(params[:inst_id])
      logger.info ("In the update method")
      install = params[:installation]
      logger.info( install )
      @new_installation.rel_template_id = install['rel_template_id']
      @new_installation.is_started=true
      @new_installation.environment_id=install['environment_id']
      @new_installation.release = install['release']

      @new_installation.save!

      @template = RelTemplate.find(@new_installation.rel_template_id)

      @template.rel_template_item.each() do |i|
        @new_installation.item_per_installation.create(rel_template_item_id:i.id)
      end

      redirect_to '/my_installation/viewinstall/'+@new_installation.id.to_s
    end


  
  def viewinstall
    @installation = Installation.find(params[:id])
    commontator_thread_show(@installation)
    @activities = PublicActivity::Activity.where(trackable_type:'ItemPerInstallation').where(recipient: @installation).limit(100).order(created_at: :desc)

    @rmobjects  = ReleaseManager.getObjectForRelease(@installation.release)


  end
  
  def testview
    @installation = Installation.find(params[:id])
    @activities = PublicActivity::Activity.where(trackable_type:'ItemPerInstallation').where(recipient: @installation).limit(100).order(created_at: :desc)
  end
  
  def ongoing
    @installations = Installation.where(is_started:true).where("is_done is null").order(created_at: :desc)
  end
  
  
  
   private
    # Use callbacks to share common setup or constraints between actions.
    def set_installation
      @installation = Installation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def installation_params
      params.require(:installation).permit(:release,:rel_template_id,:environment_id,:installation_id)
    end


end
