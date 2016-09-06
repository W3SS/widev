class RelTemplateItemsController < ApplicationController
  before_action :set_rel_template_item, only: [:show, :edit, :update, :destroy]

  # GET /rel_template_items
  # GET /rel_template_items.json
  def index
    @rel_template_items = RelTemplateItem.all
  end

  # GET /rel_template_items/1
  # GET /rel_template_items/1.json
  def show
  end

  # GET /rel_template_items/new
  def new
    @rel_template_item = RelTemplateItem.new
  end

  # GET /rel_template_items/1/edit
  def edit
  end

  # POST /rel_template_items
  # POST /rel_template_items.json
  def create
    @rel_template_item = RelTemplateItem.new(rel_template_item_params)

    respond_to do |format|
      if @rel_template_item.save
        format.html { redirect_to @rel_template_item, notice: 'Rel template item was successfully created.' }
        format.json { render :show, status: :created, location: @rel_template_item }
      else
        format.html { render :new }
        format.json { render json: @rel_template_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rel_template_items/1
  # PATCH/PUT /rel_template_items/1.json
  def update
    respond_to do |format|
      if @rel_template_item.update(rel_template_item_params)
        format.html { redirect_to @rel_template_item, notice: 'Rel template item was successfully updated.' }
        format.json { render :show, status: :ok, location: @rel_template_item }
      else
        format.html { render :edit }
        format.json { render json: @rel_template_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rel_template_items/1
  # DELETE /rel_template_items/1.json
  def destroy
    @rel_template_item.destroy
    respond_to do |format|
      format.html { redirect_to rel_template_items_url, notice: 'Rel template item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rel_template_item
      @rel_template_item = RelTemplateItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rel_template_item_params
      params.require(:rel_template_item).permit(:name, :description, :note, :command)
    end
end
