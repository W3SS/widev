class Api::InstallationController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token

  def startTask
     
    @item = ItemPerInstallation.find(params[:id]);
    @item.start_time = DateTime.now
    @item.is_started = true
    @item.save!
    @item.create_activity key: 'item_per_installation.started', owner: current_user,recipient: @item.installation

     respond_to do |format|
        format.json { render :show, status: :ok, location: @item }
     end
  end

  def endTask
     @item = ItemPerInstallation.find(params[:id]);
    @item.end_time =DateTime.now
    @item.is_done = true
    @item.save!
    
    @item.create_activity key: 'item_per_installation.done', owner: current_user,recipient: @item.installation

    
     respond_to do |format|
        format.json { render :show, status: :ok, location: @item }
     end
  end

  def errorTask
    @item = ItemPerInstallation.find(params[:id]);
    @item.end_time =DateTime.now
    @item.is_error = true
    @item.save!
    
    @item.create_activity key: 'item_per_installation.error', owner: current_user,recipient: @item.installation

    
     respond_to do |format|
        format.json { render :show, status: :ok, location: @item }
     end
  end

 def setnaTask
      
    @item = ItemPerInstallation.find(params[:id]);
    @item.end_time = DateTime.now
    @item.start_time = DateTime.now
    @item.is_done = true
    @item.is_na = true
    @item.save!
    
    @item.create_activity key: 'item_per_installation.done', owner: current_user,recipient: @item.installation

    
     respond_to do |format|
        format.json { render :show, status: :ok, location: @item }
     end
  end
  
  
  
  def complete
      @installation = Installation.find(params[:id]);
      @installation.is_done =true;
      @installation.save!
      
      respond_to do |format|
        format.json { render :showinst, status: :ok, location: @installation }
     end
  end
  
  
  def additem
    @newitem = RelTemplateItem.new
    @newitem.name  = params[:item_name]
    @newitem.save!
    
    @installation = Installation.find(params[:installation_id]);
    
    @installation.item_per_installation.create(rel_template_item_id: @newitem.id, is_extra:true)
    
    @item = ItemPerInstallation.where(rel_template_item_id: @newitem.id , installation_id:params[:installation_id] ).first()
    
    @item.create_activity key: 'item_per_installation.custom', owner: current_user,recipient: @item.installation

    respond_to do |format|
        format.json { render :show, status: :ok, location: @item }
     end
  end
  
  
end
