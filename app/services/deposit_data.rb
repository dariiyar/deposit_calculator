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
      @data[:currency] = @deposit.currency
      @data[:amount] = @deposit.amount
      @data[:interest_payout] = @deposit.interest
      @data[:total_payout] = @deposit.total_payout
      @data[:total_days] = @deposit.total_days
      @data[:months_table] = months_table
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
  end
end
