class DepositsController < ApplicationController
  get '/' do
    @deposit = Deposit.new
    slim :form, layout: 'layout.slim'
  end

  get '/calculate' do
    @deposit = Deposit.new(params.reject { |p| p.start_with?('_') })
    render 'calculate.js.erb'
  end
end
