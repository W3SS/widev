class ReltypesController < ApplicationController
  before_action :set_reltype, only: [:show, :edit, :update, :destroy]

  # GET /reltypes
  # GET /reltypes.json
  def index
    @reltypes = Reltype.all
  end

  # GET /reltypes/1
  # GET /reltypes/1.json
  def show
  end

  # GET /reltypes/new
  def new
    @reltype = Reltype.new
  end

  # GET /reltypes/1/edit
  def edit
  end

  # POST /reltypes
  # POST /reltypes.json
  def create
    @reltype = Reltype.new(reltype_params)

    respond_to do |format|
      if @reltype.save
        format.html { redirect_to @reltype, notice: 'Reltype was successfully created.' }
        format.json { render :show, status: :created, location: @reltype }
      else
        format.html { render :new }
        format.json { render json: @reltype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reltypes/1
  # PATCH/PUT /reltypes/1.json
  def update
    respond_to do |format|
      if @reltype.update(reltype_params)
        format.html { redirect_to @reltype, notice: 'Reltype was successfully updated.' }
        format.json { render :show, status: :ok, location: @reltype }
      else
        format.html { render :edit }
        format.json { render json: @reltype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reltypes/1
  # DELETE /reltypes/1.json
  def destroy
    @reltype.destroy
    respond_to do |format|
      format.html { redirect_to reltypes_url, notice: 'Reltype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reltype
      @reltype = Reltype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reltype_params
      params.require(:reltype).permit(:name, :color, :short)
    end
end
