require_relative "boot"
require "rails/all"
Bundler.require(*Rails.groups)
module SampleApp
  class Application < Rails::Application
    I18n.default_locale = :ja
  end
end