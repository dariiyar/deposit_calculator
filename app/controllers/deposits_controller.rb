class DepositsController < ApplicationController
  get '/' do
    @deposit = Deposit.new
    slim :new, layout: 'layout.slim'
  end
end
