require_relative '../spec_helper'

RSpec.describe Services::DepositData do
  describe '#perform' do
    context 'with valid deposit object' do
      let!(:deposit) do
        Deposit.new amount: 500, currency: 'UAH', interest_rate: 10, start_date: '23 Tue 2020', period: 3, period_type: 'months'
      end
      let(:data) do
        { amount: 500,
          currency: 'UAH',
          interest_payout: 12.60,
          total: 512.60 }
      end
      let(:result) { subject.perform(deposit) }
      subject { described_class }

      it 'renders proper data' do
        expect(result.data[:interest_payout].to_f.round(2)).to eq(data[:interest_payout])
        expect((result.data[:amount] + result.data[:interest_payout]).to_f.round(2)).to eq(data[:total])
      end
    end
  end
end
