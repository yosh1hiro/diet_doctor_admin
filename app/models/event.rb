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

    def count_sum_values(code)
      source = Event.where(event_code: code).where('occur >= ?', @from).where('occur <= ?', @to).group(:occur).sum(:value)
      source.each do |k, v|
        i = k - @from
        @recs[i] += v
      end
      @recs
    end

    def count_unique_users(code)
      source = Event.where(event_code: code).where('occur >= ?', @from).where('occur <= ?', @to).select(:occur, :user_id).uniq.group(:occur).count(:user_id)
      source.each do |k, v|
        i = k - @from
        @recs[i] += v
      end
      @recs
    end

    def count_registers
      count_sum_values REGISTER
    end

    def cumulative_users
      count_sum_values CONNECT
    end

    def unique_users
      count_unique_users CONNECT
    end

    def counsel_counts
      count_sum_values COUNSEL
    end

    def counsel_users
      count_unique_users COUNSEL
    end

    def ddq_purchases
      count_sum_values DD_CLINIC
    end

    def pro_purchases
      count_sum_values PRO_EDITION
    end
  end
end
