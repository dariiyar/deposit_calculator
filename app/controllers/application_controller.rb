class ApplicationController < Sinatra::Base
  register Sinatra::ApplicationSettings
  app_settings
  register Padrino::Helpers

  def self.protect_from_csrf
    false
  end
end
