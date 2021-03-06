require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TasksManagement
  class Application < Rails::Application
    config.load_defaults 5.2
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.generators do |g|
      # Railsジェネレータがfactory_bot用のファイルを生成するのを無効化(今回は使用するので不要)
      # g.factory_bot false
      g.test_framework :rspec,
              #テストで初期データを投入する  railsの機能 今回bot使用なので不要(?)のはず。。。
              # fixtures: true,
              # model_specs: true,
              view_specs: false,
              helper_specs: false,
              routing_specs: false,
              controller_specs: false,
              request_specs: false
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
