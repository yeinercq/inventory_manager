module Sales::TotalPerDateRange
  extend ActiveSupport::Concern

  module ClassMethods
    def total_this_month
      this_month.valid_countable.sum(&:total_price)
    end

    def total_last_month
      last_month.valid_countable.sum(&:total_price)
    end

    def total_this_year
      this_year.valid_countable.sum(&:total_price)
    end

    def total_earnings_last_month
      earnings = []
      last_month.valid_countable.each { |sale| earnings << sale.total_earning }
      earnings.sum
    end
    def total_earnings_this_month
      earnings = []
      this_month.valid_countable.each { |sale| earnings << sale.total_earning }
      earnings.sum
    end
    def total_earnings_this_year
      earnings = []
      this_year.valid_countable.each { |sale| earnings << sale.total_earning }
      earnings.sum
    end
  end
end
