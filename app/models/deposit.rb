class Deposit
  include ActiveModel::Validations

  ATTRS = %i[currency amount interest_rate start_date period period_type inflation_rate].freeze
  attr_accessor(*ATTRS)

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
            numericality: { only_integer: true,
                            greater_than: 0,
                            message: 'should be number and equal or bigger than 1' }
  validate do
    DateTime.parse(start_date)
  rescue StandardError
    errors[:start_date] << 'must be a valid date'
  end

  def initialize(attr = {})
    attr.each_key.each { |key| send("#{key}=", attr[key]) }
  end

  def self.attributes
    ATTRS
  end
end
