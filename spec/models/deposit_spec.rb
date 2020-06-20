require_relative '../spec_helper'

RSpec.describe Deposit, type: :model do
  subject { FactoryBot.build(:deposit) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid with wrong currency' do
    subject.currency = 'BLG'
    expect(subject).not_to be_valid
  end
  it 'is not valid when is less than 100' do
    subject.amount = 99.99
    expect(subject).not_to be_valid
  end
  it 'is not valid when is period is less than 0' do
    subject.period = 0
    expect(subject).not_to be_valid
  end
  it 'is not valid with wrong start date type' do
    subject.start_date = 'AAA'
    expect(subject).not_to be_valid
  end
end
