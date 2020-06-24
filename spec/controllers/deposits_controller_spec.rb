require_relative '../spec_helper'

describe DepositsController do
  describe 'GET /' do
    it 'responds with a status 200' do
      get '/'
      expect(last_response.status).to eq(200)
    end
  end
  describe 'GET /calculate' do
    let(:deposit) { FactoryBot.build(:deposit) }
    let(:result_double) { double('result_double') }

    before :each do
      allow(Services::DepositData).to receive(:perform).and_return(result_double)
      allow(result_double).to receive(:data).and_return({})
      allow(result_double).to receive(:errors).and_return([])
    end

    context 'with valid params' do
      it 'renders the calculation result' do
        allow(result_double).to receive(:success?).and_return(true)
        expect_any_instance_of(Padrino::Helpers::RenderHelpers).to receive(:render).with('calculation_result.js.erb', locals: { data: result_double.data })
        get '/calculate', params: {}
      end
    end
    context 'with invalid params' do
      it 'renders the calculation result' do
        allow(result_double).to receive(:success?).and_return(false)
        expect_any_instance_of(Padrino::Helpers::RenderHelpers).to receive(:render).with('calculation_error.js.erb', locals: { errors: result_double.errors })
        get '/calculate', params: {}
      end
    end
  end
end
