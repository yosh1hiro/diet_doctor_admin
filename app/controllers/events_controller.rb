class EventsController < ApplicationController

  def create
    @event = Event.create(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to challenges_url, notice: '追加しました。' }
        format.json { render json: @event, status: 200 }
      else
        format.html { redirect_to challenges_url, alert: '追加できませんでした。' }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def event_params
    params.required(:event).permit [
        :occur,
        :user_id,
        :event_code,
        :value
    ]
  end
end
