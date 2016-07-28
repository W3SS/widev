class ItemPerInstallationsController < ApplicationController
  before_action :set_item_per_installation, only: [:show, :edit, :update, :destroy]

  # GET /item_per_installations
  # GET /item_per_installations.json
  def index
    @item_per_installations = ItemPerInstallation.all
  end

  # GET /item_per_installations/1
  # GET /item_per_installations/1.json
  def show
  end

  # GET /item_per_installations/new
  def new
    @item_per_installation = ItemPerInstallation.new
  end

  # GET /item_per_installations/1/edit
  def edit
  end

  # POST /item_per_installations
  # POST /item_per_installations.json
  def create
    @item_per_installation = ItemPerInstallation.new(item_per_installation_params)

    respond_to do |format|
      if @item_per_installation.save
        format.html { redirect_to @item_per_installation, notice: 'Item per installation was successfully created.' }
        format.json { render :show, status: :created, location: @item_per_installation }
      else
        format.html { render :new }
        format.json { render json: @item_per_installation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_per_installations/1
  # PATCH/PUT /item_per_installations/1.json
  def update
    respond_to do |format|
      if @item_per_installation.update(item_per_installation_params)
        format.html { redirect_to @item_per_installation, notice: 'Item per installation was successfully updated.' }
        format.json { render :show, status: :ok, location: @item_per_installation }
      else
        format.html { render :edit }
        format.json { render json: @item_per_installation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_per_installations/1
  # DELETE /item_per_installations/1.json
  def destroy
    @item_per_installation.destroy
    respond_to do |format|
      format.html { redirect_to item_per_installations_url, notice: 'Item per installation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_per_installation
      @item_per_installation = ItemPerInstallation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_per_installation_params
      params.require(:item_per_installation).permit(:rel_template_item, :start_time, :end_time, :installation, :is_done, :is_started, :is_error, :note)
    end
end
