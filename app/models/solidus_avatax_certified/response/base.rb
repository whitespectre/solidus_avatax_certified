# frozen_string_literal: true

module SolidusAvataxCertified
  module Response
    class Base
      attr_accessor :result, :faraday

      def initialize(faraday)
        @faraday = faraday.is_a?(Hash) ? OpenStruct.new({ body: faraday }) : faraday
      end

      def result
        @result ||= faraday.body
      end

      def success?
        faraday.success?
      end

      def error?
        !success?
      rescue StandardError
        true
      end

      def description
        raise 'Method needs to be implemented in subclass.'
      end
    end
  end
end
