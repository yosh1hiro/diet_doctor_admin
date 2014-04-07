class CounselCommentsController < ApplicationController
  before_action :set_counsel_comment, only: [:show, :edit, :update, :destroy]

  # GET /counsel_comments
  # GET /counsel_comments.json
  def index
    @counsel_comments = CounselComment.all
  end

  # GET /counsel_comments/1
  # GET /counsel_comments/1.json
  def show
  end

  # GET /counsel_comments/new
  def new
    @counsel_comment = CounselComment.new
  end

  # GET /counsel_comments/1/edit
  def edit
  end

  # POST /counsel_comments
  # POST /counsel_comments.json
  def create
    @counsel_comment = CounselComment.new(counsel_comment_params)

    respond_to do |format|
      if @counsel_comment.save
        format.html { redirect_to @counsel_comment, notice: 'Counsel comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @counsel_comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @counsel_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /counsel_comments/1
  # PATCH/PUT /counsel_comments/1.json
  def update
    respond_to do |format|
      if @counsel_comment.update(counsel_comment_params)
        format.html { redirect_to @counsel_comment, notice: 'Counsel comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @counsel_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /counsel_comments/1
  # DELETE /counsel_comments/1.json
  def destroy
    @counsel_comment.destroy
    respond_to do |format|
      format.html { redirect_to counsel_comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_counsel_comment
      @counsel_comment = CounselComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def counsel_comment_params
      params[:counsel_comment]
    end
end
