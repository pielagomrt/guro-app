module Exceptions
  module ApplicationErrors
    class CreateGradingSystemError < StandardError
      attr_reader :alert

      def initialize(data)
        @alert = data[:alert]
        super
      end
    end
  end
end
