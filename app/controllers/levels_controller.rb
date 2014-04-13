class LevelsController < ApplicationController
  before_action :set_level, only: [:picture]

  def picture
    send_data @level.image
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_level
    @level = Level.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def level_params
    params[:levels]
  end
end
