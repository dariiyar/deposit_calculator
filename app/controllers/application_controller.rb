class ApplicationController < Sinatra::Base
  register Sinatra::ApplicationSettings
  register Padrino::Helpers

  helpers Sinatra::ViewsHelper

  app_settings

  def self.protect_from_csrf
    false
  end
end
