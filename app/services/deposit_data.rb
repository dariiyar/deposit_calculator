module Services
  class DepositData
    def self.perform(*args, &block)
      new(*args, &block).perform
    end

    def initialize(deposit)
      @deposit = deposit
      @data = {}
    end

    def perform
      return OpenStruct.new(success?: false, errors: @deposit.errors.messages) unless @deposit.valid?
      OpenStruct.new(success?: true, data: data)
    end

    private

    def data
      %i[currency amount interest total_days total_payout].each { |attr| @data[attr] = @deposit.send(attr) }
      @data[:months_table] = months_table
      inflation_data
      @data
    end

    def months_table
      (0..(@deposit.total_months)).each_with_object([]) { |index, ar| ar << table_row(index) }
    end

    def table_row(index)
      first_month = index.zero?
      date = @deposit.start_date + index.month
      row = [date.strftime('%d %b %Y'), (first_month ? '' : (date - (date - 1.month)).to_i), @deposit.amount]
      row << (first_month ? '' : row[1] * @deposit.day_interest)
    end

    def inflation_data
      if @deposit.inflation_rate.present? && @deposit.inflation_rate > 0
        @data[:interest_with_inflation] = @deposit.interest_with_inflation
        @data[:total_payout_with_inflation] = @deposit.total_payout_with_inflation
      end
    end
  end
end
