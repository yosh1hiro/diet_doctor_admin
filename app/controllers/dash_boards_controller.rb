class DashBoardsController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.json { head 200 }
    end
  end
end
