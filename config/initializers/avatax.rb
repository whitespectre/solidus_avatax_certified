# frozen_string_literal: true

# DO NOT MODIFY FILE
AVATAX_HEADERS = { 'X-Avalara-Client' => ENV.fetch('AVATAX_CLIENT_ID') }.freeze

module Spree
  module Avatax
    Config = Spree::AvataxConfiguration.new
  end
end
