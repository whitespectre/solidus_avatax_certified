# frozen_string_literal: true

require 'solidus_support'
require_relative './config'

module SolidusAvataxCertified
  class Engine < Rails::Engine
    include ::SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_avatax_certified'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.to_prepare do
      ::Spree::PermittedAttributes.user_attributes.concat(%i[avalara_entity_use_code_id exemption_number vat_id])
      Rails.application.config.spree.calculators.tax_rates << ::Spree::Calculator::AvalaraTransaction
      ::Spree::Config.tax_adjuster_class = ::SolidusAvataxCertified::OrderAdjuster
    end
  end
end
