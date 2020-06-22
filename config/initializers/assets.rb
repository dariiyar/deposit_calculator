module Sinatra
  module ApplicationSettings
    def assets_settings
      configure do
        # initialize new sprockets environment
        set :environment, Sprockets::Environment.new(File.join(root, 'app'))
        set :assets_prefix, '/assets'
        set :digest_assets, true

        environment.js_compressor  = Uglifier.new(harmony: true)
        environment.css_compressor = :scss

        environment.append_path File.join(root, 'app', 'assets', 'stylesheets')
        environment.append_path File.join(root, 'app', 'assets', 'javascripts')
        environment.append_path File.join(root, 'app', 'assets', 'images')

        Sprockets::Helpers.configure do |config|
          config.environment = environment
          config.prefix      = assets_prefix
          config.digest      = digest_assets
          config.public_path = public_folder
          # Force to debug mode in development mode
          # Debug mode automatically sets
          # expand = true, digest = false, manifest = false
          # config.debug = ENV['SINATRA_ENV']=='development'
        end
        # get assets
        get '/assets/*' do
          env['PATH_INFO'].sub!('/assets', '')
          settings.environment.call(env)
        end
      end
    end
  end
end
