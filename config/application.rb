require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

APP_CONFIG = YAML.load_file(File.expand_path "../app_config.yml", __FILE__)[Rails.env].symbolize_keys!
 

module Cloudportal
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '*/')]

    config.assets.paths << Rails.root.join("app", "assets", "fonts")

  end
end
