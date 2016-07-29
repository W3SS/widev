class Api::InstallationController < ApplicationController
  respond_to :json
  
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
  
  def complete
      @installation = Installation.find(params[:id]);
      @installation.is_done =true;
      @installation.save!
      
      respond_to do |format|
        format.json { render :showinst, status: :ok, location: @installation }
     end
  end
  
end
