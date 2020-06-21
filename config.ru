require './config/application'
use Rack::SassC, {
  syntax: :scss,
  css_location: File.join(File.expand_path('', File.dirname(__FILE__)), 'app/assets/stylesheets/'),
  scss_location: File.join(File.expand_path('', File.dirname(__FILE__)), 'app/assets/stylesheets/scss'),
  create_map_file: false,
  style: :compressed
}
use DepositsController
run Sinatra::Application
