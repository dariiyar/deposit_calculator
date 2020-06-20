class DepositsController < ApplicationController
  get '/' do
    slim :new
  end
end
