class Time::ReasonsController < ApplicationController
  before_action :set_time_reason, only: [:show, :edit, :update, :destroy]

  # GET /time/reasons
  # GET /time/reasons.json
  def index
    @time_reasons = Time::Reason.all
  end

  # GET /time/reasons/1
  # GET /time/reasons/1.json
  def show
  end

  # GET /time/reasons/new
  def new
    @time_reason = Time::Reason.new
  end

  # GET /time/reasons/1/edit
  def edit
  end

  # POST /time/reasons
  # POST /time/reasons.json
  def create
    @time_reason = Time::Reason.new(time_reason_params)

    respond_to do |format|
      if @time_reason.save
        format.html { redirect_to @time_reason, notice: 'Reason was successfully created.' }
        format.json { render :show, status: :created, location: @time_reason }
      else
        format.html { render :new }
        format.json { render json: @time_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time/reasons/1
  # PATCH/PUT /time/reasons/1.json
  def update
    respond_to do |format|
      if @time_reason.update(time_reason_params)
        format.html { redirect_to @time_reason, notice: 'Reason was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_reason }
      else
        format.html { render :edit }
        format.json { render json: @time_reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time/reasons/1
  # DELETE /time/reasons/1.json
  def destroy
    @time_reason.destroy
    respond_to do |format|
      format.html { redirect_to time_reasons_url, notice: 'Reason was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_reason
      @time_reason = Time::Reason.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_reason_params
      params.require(:time_reason).permit(:name,:fcast_value, :chageable)
    end
end
