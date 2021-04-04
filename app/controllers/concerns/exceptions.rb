module Exceptions
  module ApplicationErrors
    class CreationProcessError < StandardError
      attr_reader :resource, :path

      def initialize(data)
        @resource = data[:resource]
        @path = data[:path]
        super
      end
    end

    class InvalidScoresError < StandardError
      attr_reader :message, :path

      def initialize(data)
        @message = 'Student scores should not exceed the max score'
        @path = data[:path]
        super
      end
    end
  end
end
