# frozen_string_literal: true

require "simplecov"
SimpleCov.start "rails"

ENV["RAILS_ENV"] ||= "test"

require File.expand_path('dummy/config/environment.rb', __dir__)
require 'rspec/rails'
require 'capybara'

require 'spree/testing_support/preferences'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/capybara_ext'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/url_helpers'
require 'spree/testing_support/order_walkthrough'

require "webdrivers"

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!

  config.example_status_persistence_file_path = "./spec/examples.txt"

  config.include Spree::TestingSupport::ControllerRequests, type: :controller
  config.include FactoryBot::Syntax::Methods
end

require 'database_cleaner'
require 'spree/testing_support/factories'
require './spec/modified_spree_factories/avalara_factories'
