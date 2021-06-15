# frozen_string_literal: true

require 'solidus_support'

module SolidusAvataxCertified
  class Engine < Rails::Engine
    include ::SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_avatax_certified'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'solidus_avatax_certified.init_config' do
      require_relative './config'
    end

    config.to_prepare do
      # load config when local ENV is loaded

      ::Spree::PermittedAttributes.user_attributes.concat(%i[avalara_entity_use_code_id exemption_number vat_id])
      Rails.application.config.spree.calculators.tax_rates << ::Spree::Calculator::AvalaraTransaction
      ::Spree::Config.tax_adjuster_class = ::SolidusAvataxCertified::OrderAdjuster
    end
  end
end
