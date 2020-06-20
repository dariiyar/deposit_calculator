ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
require_all(Dir.glob('config/**/*.rb').reject { |f| !f.include?(ENV['SINATRA_ENV']) || f.include?('application.rb') })

module Sinatra
  module ApplicationSettings
    def app_settings
      configure do
        set :root, File.expand_path('../', File.dirname(__FILE__))
        set :views, (proc { File.join(root, 'app/views/') })
        set :public_folder, (proc { File.join(root, 'app/assets/') })
      end
      env_settings
    end
  end
end

require_all 'app'
