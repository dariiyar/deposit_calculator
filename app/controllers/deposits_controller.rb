class DepositsController < ApplicationController
  get '/' do
    @deposit = Deposit.new
    slim :form, layout: 'layout.slim'
  end

  get '/calculate' do
    result = Services::DepositData.perform(Deposit.new(params.reject { |p| p.start_with?('_') }))
    if result.success?
      render 'calculation_result.js.erb', locals: { data: result.data }
    else
      render 'calculation_error.js.erb', locals: { errors: result.errors }
    end
  end
end
