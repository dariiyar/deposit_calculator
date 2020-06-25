class Deposit
  include ActiveModel::Validations
  include Concerns::Deposit::Attributes

  validates :currency, presence: true, inclusion: { in: CURRENCIES, message: '%{value} is not a valid type' }
  validates :amount,
            presence: true,
            numericality: { greater_than_or_equal_to: 100, message: 'should be equal or bigger than 100' }
  validates :interest_rate,
            presence: true,
            numericality: { greater_than: 0, less_than_or_equal_to: 100 }
  validates :period,
            presence: true,
            numericality: { only_integer: true,
                            greater_than: 0,
                            message: 'should be number and equal or bigger than 1' }
  validates :period_type, presence: true, inclusion: { in: PERIOD_TYPES, message: '%{value} is not a valid type' }
  validates :inflation_rate,
            allow_blank: true,
            numericality: { greater_than: 0,
                            message: 'should be number and equal or bigger than 1' }
  validate do
    Date.parse(start_date) unless start_date.instance_of?(Date)
  rescue StandardError
    errors[:start_date] << 'must be a valid date'
  end

  def initialize(attr = {})
    attr.each_key.each { |key| send("#{key}=", attr[key]) }
  end

  def total_months
    period_type == 'months' ? period : period * 12
  end

  def total_days
    ((start_date + total_months.month) - start_date).to_i
  end

  def day_interest_rate
    (total_days / 365.to_d * interest_rate) / total_days
  end

  def day_interest
    day_interest_rate / 100 * amount.to_d
  end

  def interest
    day_interest * total_days
  end

  def total_payout
    interest + amount
  end
end
