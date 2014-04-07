class CounselsController < ApplicationController
  before_action :set_counsel, only: [:show, :edit, :update, :destroy]

  # GET /counsels
  # GET /counsels.json
  def index
    @counsels = Counsel.all
  end

  # GET /counsels/1
  # GET /counsels/1.json
  def show
  end

  # GET /counsels/new
  def new
    @counsel = Counsel.new
  end

  # GET /counsels/1/edit
  def edit
  end

  # POST /counsels
  # POST /counsels.json
  def create
    @counsel = Counsel.new(counsel_params)

    respond_to do |format|
      if @counsel.save
        format.html { redirect_to @counsel, notice: 'Counsel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @counsel }
      else
        format.html { render action: 'new' }
        format.json { render json: @counsel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /counsels/1
  # PATCH/PUT /counsels/1.json
  def update
    respond_to do |format|
      if @counsel.update(counsel_params)
        format.html { redirect_to @counsel, notice: 'Counsel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @counsel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /counsels/1
  # DELETE /counsels/1.json
  def destroy
    @counsel.destroy
    respond_to do |format|
      format.html { redirect_to counsels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_counsel
      @counsel = Counsel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def counsel_params
      params[:counsel]
    end
end
