class Siebel::ParametersController < ApplicationController
  before_action :set_siebel_parameter, only: [:show, :edit, :update, :destroy]

  def import

  end

  def compare

    @dist_ent = Siebel::Parameter.uniq.pluck(:enterprise)
    @dist_server = Siebel::Parameter.uniq.pluck(:server)
    @dist_comp = Siebel::Parameter.uniq.pluck(:component)


  end


  def compareview

    enta = params[:enta]
    serva = params[:serva]
    compa = params[:compa]
    entb = params[:entb]
    servb = params[:servb]
    compb = params[:compb]
    hideeq = params[:hideeq]

    @paramcomp = []
    @aligncommand = []
    parametriA = Siebel::Parameter.where(:enterprise => enta, :server=>serva ,:component => compa)

    parametriA.each do |par|
      parb = Siebel::Parameter.where(:enterprise => entb, :server=>servb ,:component => compb, :pa_alias=> par.pa_alias, :ptype=> par.ptype ).first
      css_class=""
      if (parb == nil)
        css_class = "notpresent"
      else
        if parb.pa_value != par.pa_value
          css_class="different"
          @aligncommand << "change param " + parb.pa_alias + "=\"" + parb.pa_value + "\" for comp "+compb
        else
          css_class="equal"
        end
      end

      if hideeq == "1"
        if parb != nil
            if parb.pa_value != par.pa_value
              @paramcomp <<  { :pa => par, :pb => parb , :css_class => css_class}
            end
        else
             @paramcomp <<  { :pa => par, :pb => parb , :css_class => css_class}
        end
      else
        @paramcomp <<  { :pa => par, :pb => parb , :css_class => css_class}
      end
    end

    logger.info(@paramcomp)

  end

  def load
    if( params[:file] )
      logger.info ("Param file found.... start import")
      Siebel::Parameter.import(params[:file],params[:ptype],params[:enterprise],params[:server],params[:component])
      redirect_to '/siebel/parameters' , notice: "Parameters imported."
    else
      logger.info ("Param file not found.... start import spool")
      Siebel::Parameter.importspool(params[:srvspool],params[:ptype],params[:enterprise],params[:server],params[:component])
      redirect_to '/siebel/parameters' , notice: "Parameters imported."
    end


  end

  # GET /siebel/parameters
  # GET /siebel/parameters.json
  def index
    @siebel_parameters = Siebel::Parameter.all
  end

  # GET /siebel/parameters/1
  # GET /siebel/parameters/1.json
  def show
  end

  # GET /siebel/parameters/new
  def new
    @siebel_parameter = Siebel::Parameter.new
  end

  # GET /siebel/parameters/1/edit
  def edit
  end

  # POST /siebel/parameters
  # POST /siebel/parameters.json
  def create
    @siebel_parameter = Siebel::Parameter.new(siebel_parameter_params)

    respond_to do |format|
      if @siebel_parameter.save
        format.html { redirect_to @siebel_parameter, notice: 'Parameter was successfully created.' }
        format.json { render :show, status: :created, location: @siebel_parameter }
      else
        format.html { render :new }
        format.json { render json: @siebel_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /siebel/parameters/1
  # PATCH/PUT /siebel/parameters/1.json
  def update
    respond_to do |format|
      if @siebel_parameter.update(siebel_parameter_params)
        format.html { redirect_to @siebel_parameter, notice: 'Parameter was successfully updated.' }
        format.json { render :show, status: :ok, location: @siebel_parameter }
      else
        format.html { render :edit }
        format.json { render json: @siebel_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /siebel/parameters/1
  # DELETE /siebel/parameters/1.json
  def destroy
    @siebel_parameter.destroy
    respond_to do |format|
      format.html { redirect_to siebel_parameters_url, notice: 'Parameter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_siebel_parameter
      @siebel_parameter = Siebel::Parameter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def siebel_parameter_params
      params.require(:siebel_parameter).permit(:ptype, :pa_value, :pa_alias, :pa_setlevel, :server, :enterprise, :version)
    end
end
