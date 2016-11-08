class SkillsToProfilesController < ApplicationController
  before_action :set_skills_to_profile, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  # GET /skills_to_profiles
  # GET /skills_to_profiles.json
  def index
    @skills_to_profiles = SkillsToProfile.all
  end

  # GET /skills_to_profiles/1
  # GET /skills_to_profiles/1.json
  def show
  end

  # GET /skills_to_profiles/new
  def new
    @skills_to_profile = SkillsToProfile.new
  end

  # GET /skills_to_profiles/1/edit
  def edit
  end

  # POST /skills_to_profiles
  # POST /skills_to_profiles.json
  def create
    @skills_to_profile = SkillsToProfile.new(skills_to_profile_params)

    respond_to do |format|
      if @skills_to_profile.save
        format.html { redirect_to @skills_to_profile, notice: 'Skills to profile was successfully created.' }
        format.json { render :show, status: :created, location: @skills_to_profile }
      else
        format.html { render :new }
        format.json { render json: @skills_to_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /skills_to_profiles/1
  # PATCH/PUT /skills_to_profiles/1.json
  def update
    respond_to do |format|
      if @skills_to_profile.update(skills_to_profile_params)
        format.html { redirect_to @skills_to_profile, notice: 'Skills to profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @skills_to_profile }
      else
        format.html { render :edit }
        format.json { render json: @skills_to_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def tableview
    @skills = Skill.all
    @profiles = UserProfile.where(skill_team: "IDC-DEV")


  end

  # DELETE /skills_to_profiles/1
  # DELETE /skills_to_profiles/1.json
  def destroy
    @skills_to_profile.destroy
    respond_to do |format|
      format.html { redirect_to skills_to_profiles_url, notice: 'Skills to profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skills_to_profile
      @skills_to_profile = SkillsToProfile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skills_to_profile_params
      params.require(:skills_to_profile).permit(:proficency, :note, :add1, :add2, :skill_id, :user_profile_id)
    end
end
