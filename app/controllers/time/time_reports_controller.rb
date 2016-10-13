class Time::TimeReportsController < ApplicationController
  before_action :set_time_time_report, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /time/time_reports
  # GET /time/time_reports.json
  def index
    @time_time_reports = Time::TimeReport.all
  end

  # GET /time/time_reports/1
  # GET /time/time_reports/1.json
  def show
  end

  # GET /time/time_reports/new
  def new
    @time_time_report = Time::TimeReport.new
  end

  # GET /time/time_reports/1/edit
  def edit
  end

  # POST /time/time_reports
  # POST /time/time_reports.json
  def create

    @time_time_report = Time::TimeReport.new(time_time_report_params)

    respond_to do |format|
      if @time_time_report.save
        format.html { redirect_to @time_time_report, notice: 'Time report was successfully created.' }
        format.json { render :show, status: :created, location: @time_time_report }
      else
        format.html { render :new }
        format.json { render json: @time_time_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time/time_reports/1
  # PATCH/PUT /time/time_reports/1.json
  def update
    respond_to do |format|
      if @time_time_report.update(time_time_report_params)
        format.html { redirect_to @time_time_report, notice: 'Time report was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_time_report }
      else
        format.html { render :edit }
        format.json { render json: @time_time_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time/time_reports/1
  # DELETE /time/time_reports/1.json
  def destroy
    @time_time_report.destroy
    respond_to do |format|
      format.html { redirect_to time_time_reports_url, notice: 'Time report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_time_report
      @time_time_report = Time::TimeReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_time_report_params
      params.require(:time_report).permit(:repdate, :hours, :note,:user_id,:time_reason_id)
    end
end
