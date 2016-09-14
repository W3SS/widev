class RtcInfosController < ApplicationController
  before_action :set_rtc_info, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /rtc_infos
  # GET /rtc_infos.json
  def index
    @rtc_infos = RtcInfo.all
  end

  # GET /rtc_infos/1
  # GET /rtc_infos/1.json
  def show
    @rtc_info = RtcInfo.find_by_users_id(current_user.id)
  end



  def edit
    @rtc_info = RtcInfo.find_or_create_by(:users_id => current_user.id)
  end

  def edit_my
    @rtc_info = RtcInfo.find_by_users_id(current_user.id)

    if @rtc_info == nil
      @rtc_info = RtcInfo.new
    end
  end

  def update_my
    @rtc_info = RtcInfo.find_or_create_by(:users_id => current_user.id)
    @rtc_info.username = params[:username]
    @rtc_info.password = params[:password]
    respond_to do |format|
      if @rtc_info.save
        format.html { render :edit_my, notice: 'Rtc info was successfully updated.' }
        format.json { render :edit_my, status: :ok, location: @rtc_info }
      else
        format.html { render :edit_my }
        format.json { render json: @rtc_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /rtc_infos
  # POST /rtc_infos.json
  def create
    @rtc_info = RtcInfo.new(rtc_info_params)
    @rtc_info.users_id= current_user.id

    respond_to do |format|
      if @rtc_info.save
        format.html { redirect_to @rtc_info, notice: 'Rtc info was successfully created.' }
        format.json { render :show, status: :created, location: @rtc_info }
      else
        format.html { render :new }
        format.json { render json: @rtc_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rtc_infos/1
  # PATCH/PUT /rtc_infos/1.json
  def update
    respond_to do |format|
      if @rtc_info.update(rtc_info_params)
        format.html { redirect_to @rtc_info, notice: 'Rtc info was successfully updated.' }
        format.json { render :show, status: :ok, location: @rtc_info }
      else
        format.html { render :edit }
        format.json { render json: @rtc_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rtc_infos/1
  # DELETE /rtc_infos/1.json
  def destroy
    @rtc_info.destroy
    respond_to do |format|
      format.html { redirect_to rtc_infos_url, notice: 'Rtc info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rtc_info
      @rtc_info = RtcInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rtc_info_params
      params.require(:rtc_info).permit(:username, :password, :user_id)
    end
end
