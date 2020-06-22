class ApplicationController < Sinatra::Base
  register Sinatra::ApplicationSettings
  register Padrino::Helpers

  helpers Sinatra::ViewsHelper
  helpers Sprockets::Helpers

  app_settings

  def self.protect_from_csrf
    false
  end
end
