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
    # Internationalization
    # config.i18n.available_locales = [:en, :ru]
    # config.i18n.default_locale = :en
    # config.i18n.fallbacks = true
  end
end
