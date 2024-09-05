require_relative "boot"
require "rails/all"
Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb, yml}').to_s]
    I18n.available_locales = [:en, :ja]
    I18n.default_locale = :ja
  end
end
