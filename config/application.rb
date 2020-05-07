require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dagglo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Use SuckerPunch for background jobs.
    config.active_job.queue_adapter = :sucker_punch

    # https://www.schneems.com/2017/11/08/80-smaller-rails-footprint-with-rack-deflate/
    config.middleware.insert_after ActionDispatch::Static, Rack::Deflater
    
    # Internationalization
    # config.i18n.available_locales = [:en, :ru]
    # config.i18n.default_locale = :en
    # config.i18n.fallbacks = true

    config.autoload_paths += %w[lib]

    # set the default currency
    config.default_currency = :usd

    # supports :s3, :s3_multipart, or :app
    config.upload_server = if ENV["UPLOAD_SERVER"].present?
      ENV["UPLOAD_SERVER"].to_sym
    elsif Rails.env.production?
      :s3
    else
      :app
    end
  end
end
