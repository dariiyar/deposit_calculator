ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
require 'sinatra/base'
require 'padrino-helpers'

config_files = Dir.glob('config/**/*.rb').reject do |f|
  (!f.include?(ENV['SINATRA_ENV']) && f.include?('environment')) || f.include?('application.rb')
end
require_all(config_files)

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
