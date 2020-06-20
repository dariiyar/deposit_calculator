FactoryBot.define do
  factory :deposit do
    currency CURRENCIES.sample
    amount rand(100..1000)
    interest_rate rand(5..20)
    start_date rand(1..10).days.from_now.strftime('%d/%m/%y')
    period rand(1..10)
    period_type PERIOD_TYPES.sample
  end
end
