class Api::TemplateController < ApplicationController
  def getavailablesteps
      @rel_template_items = RelTemplateItem.all

     respond_to do |format|
        format.json { render :index, status: :ok }
     end
  end

  def getstepfortemplate
    @template = RelTemplate.find(params[:id])
     
    @rel_template_items = @template.rel_template_item
    
     respond_to do |format|
        format.json { render :index, status: :ok }
     end
  end

  def addsteptotemplate
      @template = RelTemplate.find(params[:templ_id])
      @rel_template_item  =RelTemplateItem.find(params[:task_id])
      
      
      
      @template.item_per_template.create(rel_template_item_id:   @rel_template_item.id)
    
    respond_to do |format|
        format.json { render :show, status: :ok }
     end
      
  end

  def removestepfromtemplate
     @template = RelTemplate.find(params[:templ_id])
      @rel_template_item  =RelTemplateItem.find(params[:task_id])
      
      
      
      @template.rel_template_item.destroy(@rel_template_item)
    
    respond_to do |format|
        format.json { render :show, status: :ok }
     end
  end
end
