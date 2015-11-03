ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'capybara/poltergeist'
require 'capybara/rails'
require 'factory_girl_rails'
require 'rspec/rails'
require 'spec_helper'
Capybara.javascript_driver = :poltergeist
require 'support/database_cleaner'
require_relative './helpers/users_helper_spec.rb'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false

end
