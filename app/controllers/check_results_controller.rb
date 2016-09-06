class CheckResultsController < ApplicationController
  before_action :set_check_result, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!



  # GET /check_results
  # GET /check_results.json
  def index
    @check_results = CheckResult.all
  end

  # GET /check_results/1
  # GET /check_results/1.json
  def show
  end

  # GET /check_results/new
  def new
    @check_result = CheckResult.new
  end

  # GET /check_results/1/edit
  def edit
  end

  # POST /check_results
  # POST /check_results.json
  def create
    @check_result = CheckResult.new(check_result_params)

    respond_to do |format|
      if @check_result.save
        format.html { redirect_to @check_result, notice: 'Check result was successfully created.' }
        format.json { render :show, status: :created, location: @check_result }
      else
        format.html { render :new }
        format.json { render json: @check_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /check_results/1
  # PATCH/PUT /check_results/1.json
  def update
    respond_to do |format|
      if @check_result.update(check_result_params)
        format.html { redirect_to @check_result, notice: 'Check result was successfully updated.' }
        format.json { render :show, status: :ok, location: @check_result }
      else
        format.html { render :edit }
        format.json { render json: @check_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /check_results/1
  # DELETE /check_results/1.json
  def destroy
    @check_result.destroy
    respond_to do |format|
      format.html { redirect_to check_results_url, notice: 'Check result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_check_result
      @check_result = CheckResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def check_result_params
      params.require(:check_result).permit(:value, :query_check_id)
    end
end
