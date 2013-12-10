class CaterotiesController < ApplicationController
  before_action :set_cateroty, only: [:show, :edit, :update, :destroy]

  # GET /cateroties
  # GET /cateroties.json
  def index
    @cateroties = Cateroty.all
  end

  # GET /cateroties/1
  # GET /cateroties/1.json
  def show
  end

  # GET /cateroties/new
  def new
    @cateroty = Cateroty.new
  end

  # GET /cateroties/1/edit
  def edit
  end

  # POST /cateroties
  # POST /cateroties.json
  def create
    @cateroty = Cateroty.new(cateroty_params)

    respond_to do |format|
      if @cateroty.save
        format.html { redirect_to @cateroty, notice: 'Cateroty was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cateroty }
      else
        format.html { render action: 'new' }
        format.json { render json: @cateroty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cateroties/1
  # PATCH/PUT /cateroties/1.json
  def update
    respond_to do |format|
      if @cateroty.update(cateroty_params)
        format.html { redirect_to @cateroty, notice: 'Cateroty was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cateroty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cateroties/1
  # DELETE /cateroties/1.json
  def destroy
    @cateroty.destroy
    respond_to do |format|
      format.html { redirect_to cateroties_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cateroty
      @cateroty = Cateroty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cateroty_params
      params.require(:cateroty).permit(:name)
    end
end
