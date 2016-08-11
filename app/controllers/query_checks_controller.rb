class QueryChecksController < ApplicationController
  before_action :set_query_check, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /query_checks
  # GET /query_checks.json
  def index
    @query_checks = QueryCheck.all
  end

  # GET /query_checks/1
  # GET /query_checks/1.json
  def show
  end

  # GET /query_checks/new
  def new
    @query_check = QueryCheck.new
  end

  # GET /query_checks/1/edit
  def edit
  end

  # POST /query_checks
  # POST /query_checks.json
  def create
    @query_check = QueryCheck.new(query_check_params)

    respond_to do |format|
      if @query_check.save
        format.html { redirect_to @query_check, notice: 'Query check was successfully created.' }
        format.json { render :show, status: :created, location: @query_check }
      else
        format.html { render :new }
        format.json { render json: @query_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /query_checks/1
  # PATCH/PUT /query_checks/1.json
  def update
    respond_to do |format|
      if @query_check.update(query_check_params)
        format.html { redirect_to @query_check, notice: 'Query check was successfully updated.' }
        format.json { render :show, status: :ok, location: @query_check }
      else
        format.html { render :edit }
        format.json { render json: @query_check.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /query_checks/1
  # DELETE /query_checks/1.json
  def destroy
    @query_check.destroy
    respond_to do |format|
      format.html { redirect_to query_checks_url, notice: 'Query check was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query_check
      @query_check = QueryCheck.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def query_check_params
      params.require(:query_check).permit(:title, :rpt_interval, :is_started, :is_paused,:is_complex,:database_id, :statement, :num_exec, :last_exec_dt)
    end
end
