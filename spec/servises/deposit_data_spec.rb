require_relative '../spec_helper'

RSpec.describe Services::DepositData do
  describe '#perform' do
    context 'with valid deposit object' do
      let!(:deposit) do
        Deposit.new amount: 500, currency: 'UAH', interest_rate: 10, inflation_rate: 10, start_date: '25 Thu 2020', period: 3, period_type: 'months'
      end
      let(:data) do
        { amount: 500,
          currency: 'UAH',
          interest: 12.60,
          total_payout: 512.60,
          interest_with_inflation: 0,
          total_payout_with_inflation: 500,
          months_table: [
            ['25 Jun 2020', '', 500.00, ''],
            ['25 Jul 2020', 30, 500.00, 4.11],
            ['25 Aug 2020', 31, 500.00, 4.25],
            ['25 Sep 2020', 31, 500.00, 4.25]
          ] }
      end
      let(:result) { subject.perform(deposit) }
      subject { described_class }

      it 'renders proper data' do
        formatted_table = result.data[:months_table].each_with_object([]) do |row, memo|
          row[2] = (format '%.2f', row[2]).to_f
          row[3] = (format '%.2f', row[3]).to_f unless row[3].is_a?(String) && row[3].empty?
          memo << row
        end
        expect(formatted_table).to eq(data[:months_table])
        expect(result.data[:interest].to_f.round(2)).to eq(data[:interest])
        expect(result.data[:total_payout].round(2)).to eq(data[:total_payout])
        expect(result.data[:interest_with_inflation].to_f.round(2)).to eq(data[:interest_with_inflation])
        expect(result.data[:total_payout_with_inflation].round(2)).to eq(data[:total_payout_with_inflation])
      end
    end
  end
end
