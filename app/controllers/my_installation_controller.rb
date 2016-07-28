class MyInstallationController < ApplicationController
  def newinstall
    @installation = Installation.new
  end
  def createinstall
    
    @installation = Installation.new(installation_params)
    @installation.is_started=true
    @installation.save!

    @template = RelTemplate.find(@installation.rel_template_id)

    @template.rel_template_item.each() do |i|
      @installation.item_per_installation.create(rel_template_item_id:i.id)
    end
  end
  
  def viewinstall
    @installation = Installation.find(params[:id])
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
      params.require(:installation).permit(:release,:rel_template_id,:environment_id)
    end
end
