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
      @data[:amount] = @deposit.amount
      @data[:months_table] = months_table
      @data[:interest_payout] = @deposit.interest
      @data
    end

    def months_table
      (1..(@deposit.total_months + 1)).each_with_object([]) { |index, ar| ar << table_row(index) }
    end

    def table_row(index)
      first_month = index.zero?
      date = @deposit.start_date + index.month
      row = [date.strftime('%d %b %Y'), (first_month ? '' : (date - (date - 1.month)).to_i), @deposit.amount]
      row << (first_month ? '' : row[1] * @deposit.day_interest)
    end
  end
end
