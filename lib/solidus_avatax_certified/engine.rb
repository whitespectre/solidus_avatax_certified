# frozen_string_literal: true

require 'solidus_support'

module SolidusAvataxCertified
  class Engine < Rails::Engine
    isolate_namespace ::Spree

    engine_name 'solidus_avatax_certified'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'solidus_avatax_certified.setup_decorators' do |app|
      if Rails.autoloaders.respond_to?(:main) && Rails.autoloaders.main.respond_to?(:ignore)
        Rails.autoloaders.main.ignore(Dir.glob(File.join(File.dirname(__FILE__), '../../app/decorators')))
        Rails.autoloaders.main.ignore(Dir.glob(File.join(File.dirname(__FILE__), '../../app/overrides')))
      end
    end

    config.to_prepare do
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/decorators/**/*.rb')).sort.each do |file|
        require_dependency file
      end

      Dir.glob(File.join(File.dirname(__FILE__), '../../app/overrides/**/*.rb')).sort.each do |file|
        require_dependency file
      end
    end
  end
end
