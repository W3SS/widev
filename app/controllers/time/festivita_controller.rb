class Time::FestivitaController < ApplicationController
  before_action :set_time_festivitum, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /time/festivita
  # GET /time/festivita.json
  def index
    @time_festivita = Time::Festivitum.all
  end

  # GET /time/festivita/1
  # GET /time/festivita/1.json
  def show
  end

  # GET /time/festivita/new
  def new
    @time_festivitum = Time::Festivitum.new
  end

  # GET /time/festivita/1/edit
  def edit
  end

  # POST /time/festivita
  # POST /time/festivita.json
  def create
    @time_festivitum = Time::Festivitum.new(time_festivitum_params)

    respond_to do |format|
      if @time_festivitum.save
        format.html { redirect_to @time_festivitum, notice: 'Festivitum was successfully created.' }
        format.json { render :show, status: :created, location: @time_festivitum }
      else
        format.html { render :new }
        format.json { render json: @time_festivitum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time/festivita/1
  # PATCH/PUT /time/festivita/1.json
  def update
    respond_to do |format|
      if @time_festivitum.update(time_festivitum_params)
        format.html { redirect_to @time_festivitum, notice: 'Festivitum was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_festivitum }
      else
        format.html { render :edit }
        format.json { render json: @time_festivitum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time/festivita/1
  # DELETE /time/festivita/1.json
  def destroy
    @time_festivitum.destroy
    respond_to do |format|
      format.html { redirect_to time_festivita_url, notice: 'Festivitum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_festivitum
      @time_festivitum = Time::Festivitum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_festivitum_params
      params.require(:time_festivitum).permit(:name, :forecast_val, :chargeable, :festdate)
    end
end
