module Sales::TotalPerDateRange
  extend ActiveSupport::Concern

  module ClassMethods
    # Class methods to total values per date range
    def total_valid_sales_per_date_range(start_date, end_date)
      filter_by_date(start_date, end_date).where('status != ? AND status !=
   ?', 'guardada', 'confirmada')
    end

    def total_this_month
      total_valid_sales_per_date_range(
        Date.current.beginning_of_month.beginning_of_day,
        Date.current.end_of_month.end_of_day
      ).sum(&:total_price)
    end

    def total_last_month
      total_valid_sales_per_date_range(
        (Date.current - 1.months).beginning_of_month.beginning_of_day,
        (Date.current - 1.months).end_of_month.end_of_day
      ).sum(&:total_price)
    end

    def total_this_year
      total_valid_sales_per_date_range(
        Date.current.beginning_of_year.beginning_of_day,
        Date.current.end_of_month.end_of_year
      ).sum(&:total_price)
    end
  end
end
