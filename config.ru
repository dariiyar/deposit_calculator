require './config/application'
run Sinatra::Application
use DepositsController
