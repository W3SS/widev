class ReleaseItemsController < ApplicationController
  before_action :set_release_item, only: [:show, :edit, :update, :destroy]


   def import
      if( params[:file] )
          release  =params[:release]
          
          logger.info ("Param file found.... start import")
          ReleaseItem.import(params[:file],release)
          redirect_to :back , notice: "Item imported."
      end
   end


  def export
    if ( params[:release])

      release = Release.find(params[:release])
      date = DateTime.now

      name = "ObjectPreview-" + release.date.strftime("%d-%m-%Y")+"-v" +date.strftime("%Y%m%dT%H%M%S")+".xlsx"
      path = "tmp/"+ name

      workbook = WriteXLSX.new(path)
      worksheets = Hash.new

      format = workbook.add_format # Add a format
      format.set_bold
      format.set_color('yellow')
      format.set_align('left')
      format.set_bg_color('blue')

      format2 = workbook.add_format # Add a format
      format2.set_align('left')
      format2.set_text_justlast



      items  = ReleaseItem.where(:release_id => params[:release])
      category = ReleaseItem.where(:release_id => params[:release]).select(:ftype).uniq

      #prepara gli sheet per le categorie
      category.each() do |cat|
        logger.info(cat)
        worksheets[cat.ftype] = workbook.add_worksheet(cat.ftype.to_s.upcase)
        worksheets[cat.ftype].write(0,   0, "Name",format)
        worksheets[cat.ftype].write(0,   1, "Removable",format)
      end

      row=1

      category.each() do |cat|
        items  = ReleaseItem.where(:release_id => params[:release]).where(:ftype =>cat.ftype.to_s)
        items.each() do |i|
          worksheets[cat.ftype].write(row,   0, i.file_name,format2)
          if i.removable
            worksheets[cat.ftype].write(row,   1, "Y")
          end
          row = row +1
        end
        row=1
      end

    end

    workbook.close

    send_file path, :type => "application/octet-stream", :filename => name, :stream => false, :disposition => 'attachment'
  end
  
  def remove_all
          release  =params[:release]
          @release = Release.find(release)
          @release.release_items.destroy_all
          @release.save!
          redirect_to :back , notice: "Item removed."
  end




  # GET /release_items
  # GET /release_items.json
  def index
    @release_items = ReleaseItem.all
  end

  # GET /release_items/1
  # GET /release_items/1.json
  def show
  end

  # GET /release_items/new
  def new
    @release_item = ReleaseItem.new
  end

  # GET /release_items/1/edit
  def edit
  end

  # POST /release_items
  # POST /release_items.json
  def create
    @release_item = ReleaseItem.new(release_item_params)

    respond_to do |format|
      if @release_item.save
        format.html { redirect_to @release_item, notice: 'Release item was successfully created.' }
        format.json { render :show, status: :created, location: @release_item }
      else
        format.html { render :new }
        format.json { render json: @release_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /release_items/1
  # PATCH/PUT /release_items/1.json
  def update
    respond_to do |format|
      if @release_item.update(release_item_params)
        format.html { redirect_to @release_item, notice: 'Release item was successfully updated.' }
        format.json { render :show, status: :ok, location: @release_item }
      else
        format.html { render :edit }
        format.json { render json: @release_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /release_items/1
  # DELETE /release_items/1.json
  def destroy
    @release_item.destroy
    respond_to do |format|
      format.html { redirect_to release_items_url, notice: 'Release item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def toggle
    @item =  ReleaseItem.find(params[:id])
    if @item.update_attributes(:removable => params[:removable])
      render json: "Success"
    else
      render json: "Failed"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_release_item
      @release_item = ReleaseItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def release_item_params
      params.require(:release_item).permit(:name, :type, :scratchable, :remove)
    end
end
