class SummariesController < ApplicationController

  def show
    @summary = Summary.new(:empty)  if @summary.nil?
  end

  def create
    @summary = Summary.new(:count_registers,  summary_params)  if params[:count_registers]
    @summary = Summary.new(:cumulative_users, summary_params)  if params[:cumulative_users]
    @summary = Summary.new(:unique_users,     summary_params)  if params[:unique_users]
    @summary = Summary.new(:counsel_counts,   summary_params)  if params[:counsel_counts]
    @summary = Summary.new(:counsel_users,    summary_params)  if params[:counsel_users]
    @summary = Summary.new(:ddq_purchases,    summary_params)  if params[:ddq_purchases]
    @summary = Summary.new(:pro_purchases,    summary_params)  if params[:pro_purchases]
    @summary = Summary.new(:practice_status,  summary_params)  if params[:practice_status]
    @summary = Summary.new(:empty)  if @summary.nil?
    render action: :show
  end

  private

  def summary_params
    params.permit [
        :summarize_term_begin,
        :summarize_term_end
    ]
  end

  class Summary
    attr_reader :required
    attr_reader :params
    attr_reader :data

    def initialize(required, params = nil)
      @required = required
      unless params.nil?
        @params = params
      else
        @params = {}
        today = Date.today
        @params[:summarize_term_begin] = today << 1
        @params[:summarize_term_end] = today
      end
      @data = count_registers   if required == :count_registers

    end

    def count_registers
      data = []
      from = Date.parse(@params[:summarize_term_begin])
      to   = Date.parse(@params[:summarize_term_end])
      d = from
      Event::Counter.new(from, to).count_registers.each do |v|
         data << {
             date: d.strftime('%Y-%m-%d'),
             show_date: d.day % 10 == 1,
             value: v
         }
        d += 1
      end
      data
    end

  end
end
