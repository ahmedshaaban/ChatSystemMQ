require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"
require 'redis'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChatSys
  class Application < Rails::Application
    Dotenv::Railtie.load

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.cache_store = :redis_cache_store, 'redis://'+ENV['REDIS_LOCALHOST']+':6379/0/cache'

    config.action_controller.perform_caching = true

    $redis = Redis::Namespace.new("ChatSys", :redis => Redis.new(host:ENV['REDIS_LOCALHOST'] ))

    Sneakers.configure :connection => Bunny.new(hostname: ENV['RABBITMQ_HOSTNAME']),
                       :exchange => 'sneakers'
    Sneakers.logger.level = Logger::INFO # the default DEBUG is too noisy
  end
end
