class Event < ActiveRecord::Base
  belongs_to :user

  # event_code
  REGISTER    = 1
  CONNECT     = 2
  COUNSEL     = 3
  DD_CLINIC   = 4
  PRO_EDITION = 5

  class Counter

    def initialize(from, to)
      @from = from
      @to = to
      @recs = []
      t = @from
      until t > @to
        @recs.push 0
        t = t + 1
      end
    end

    def range_arel(arel, column, min, max, flag = nil)
      if column == :created_at
        arel = arel.where(User.arel_table[column].gteq(min)) if min.present?
        arel = arel.where(User.arel_table[column].lt(max + 1)) if max.present?
      elsif flag == :age
        today = Date.today
        arel = arel.where(User.arel_table[column].gteq(today << 12 * (max + 1))) if max.present?
        arel = arel.where(User.arel_table[column].lt(today << 12 * min)) if min.present?
      else
        arel = arel.where(User.arel_table[column].gteq(min)) if min.present?
        arel = arel.where(User.arel_table[column].lteq(max)) if max.present?
      end
      arel
    end

    def match_arel(arel, column, target)
      if target.present?
        arel.where(User.arel_table[column].eq(target))
      else
        arel
      end
    end

    def count_arel(code, params)
      params = {} if params.nil?
      arel = Event.joins(:user).where(event_code: code).where('occur >= ?', @from).where('occur <= ?', @to)

      arel = range_arel(arel, :created_at,        params[:register_date_begin], params[:register_date_end], :user)
      arel = match_arel(arel, :gender,            params[:gender])
      arel = range_arel(arel, :birthday,          params[:age_min],             params[:age_max], :age)
      arel = match_arel(arel, :occupation,        params[:occupation])
      arel = range_arel(arel, :height,            params[:height_min],          params[:height_max])
      arel = range_arel(arel, :initial_weight,    params[:initial_weight_min],  params[:initial_weight_max])
      arel = range_arel(arel, :current_weight,    params[:current_weight_min],  params[:current_weight_max])
      arel = range_arel(arel, :loss_rate,         params[:loss_rate_min],       params[:loss_rate_max])
      arel = range_arel(arel, :initial_bmi,       params[:initial_bmi_min],     params[:initial_bmi_max])
      arel = range_arel(arel, :current_bmi,       params[:current_bmi_min],     params[:current_bmi_max])
      arel = match_arel(arel, :meal_custom,       params[:meal_custom])
      arel = match_arel(arel, :exercising_custom, params[:exercising_custom])
      if params[:contract].present?
        arel = arel.where('pro_edition == ?', params[:contract] == '契約')
      end

      arel
    end

    def count_sum_values(code, params)
      source = count_arel(code, params).group(:occur).sum(:value)
      source.each do |k, v|
        i = k - @from
        @recs[i] += v
      end
      @recs
    end

    def count_unique_users(code, params)
      source = count_arel(code, params).select(:occur, :user_id).uniq.group(:occur).count(:user_id)
      source.each do |k, v|
        i = k - @from
        @recs[i] += v
      end
      @recs
    end

    def count_registers(params)
      count_sum_values REGISTER, params
    end

    def cumulative_users(params)
      count_sum_values CONNECT, params
    end

    def unique_users(params)
      count_unique_users CONNECT, params
    end

    def counsel_counts(params)
      count_sum_values COUNSEL, params
    end

    def counsel_users(params)
      count_unique_users COUNSEL, params
    end

    def ddq_purchases(params)
      count_sum_values DD_CLINIC, params
    end

    def pro_purchases(params)
      count_sum_values PRO_EDITION, params
    end
  end
end
