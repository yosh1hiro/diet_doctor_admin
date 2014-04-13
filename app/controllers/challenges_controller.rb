class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy, :picture]

  # GET /challenges
  # GET /challenges.json
  def index
    @challenges = Challenge.order(:group).to_a
    @challenge = Challenge.new
  end

  # GET /challenges/1
  # GET /challenges/1.json
  def show
  end

  # GET /challenges/new
  def new
    @challenge = Challenge.new
  end

  # GET /challenges/1/edit
  def edit
  end

  # POST /challenges
  # POST /challenges.json
  def create
    @challenge = Challenge.new(params.require(:challenge).permit(:group))
    @challenge.levels = (1..10).map do |i|
      Level.new({group: @challenge.group, level: i})
    end
    respond_to do |format|
      if @challenge.save
        format.html { redirect_to challenges_url, notice: '追加しました。' }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      else
        format.html { redirect_to challenges_url, alert: '追加できませんでした。' }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /challenges/1
  # PATCH/PUT /challenges/1.json
  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to :challenges, notice: '保存されました' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url }
      format.json { head :no_content }
    end
  end

  def picture
    send_data @challenge.image
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge
      @challenge = Challenge.find(params[:id])
      # if @challenge.levels.nil?
      #   @challenge.levels = Level.where(group: @challenge.group).order(:levels).to_a
      # end
      # @challenge
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def challenge_params
      params.require(:challenge).permit [
          :group,
          :caption,
          :description,
          :description_1,
          :description_2,
          :description_3,
          :description_4,
          :comment,
          :category,
          :param_0,
          :param_1,
          :param_2,
          :image_file,
          levels_attributes: [
              :id,
              :group,
              :level,
              :stage,
              :rank,
              :caption,
              :description,
              :comment,
              :category,
              :tips,
              :star_count,
              :term,
              :challenge_id,
              :image_file,
              :_destroy
          ]
      ]
    end
end
