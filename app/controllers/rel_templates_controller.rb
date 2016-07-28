class RelTemplatesController < ApplicationController
  before_action :set_rel_template, only: [:show, :edit, :update, :destroy]

  # GET /rel_templates
  # GET /rel_templates.json
  def index
    @rel_templates = RelTemplate.all
  end

  # GET /rel_templates/1
  # GET /rel_templates/1.json
  def show
  end

  # GET /rel_templates/new
  def new
    @rel_template = RelTemplate.new
  end

  # GET /rel_templates/1/edit
  def edit
    @rel_template_items  = RelTemplateItem.all
  end

  # POST /rel_templates
  # POST /rel_templates.json
  def create
    @rel_template = RelTemplate.new(rel_template_params)

    respond_to do |format|
      if @rel_template.save
        format.html { redirect_to @rel_template, notice: 'Rel template was successfully created.' }
        format.json { render :show, status: :created, location: @rel_template }
      else
        format.html { render :new }
        format.json { render json: @rel_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rel_templates/1
  # PATCH/PUT /rel_templates/1.json
  def update
    respond_to do |format|
      if @rel_template.update(rel_template_params)
        format.html { redirect_to @rel_template, notice: 'Rel template was successfully updated.' }
        format.json { render :show, status: :ok, location: @rel_template }
      else
        format.html { render :edit }
        format.json { render json: @rel_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rel_templates/1
  # DELETE /rel_templates/1.json
  def destroy
    @rel_template.destroy
    respond_to do |format|
      format.html { redirect_to rel_templates_url, notice: 'Rel template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rel_template
      @rel_template = RelTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rel_template_params
      params.require(:rel_template).permit(:name)
    end
end
