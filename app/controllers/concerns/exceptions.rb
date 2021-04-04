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

    class BadRequestError < StandardError
      attr_reader :message, :path

      def initialize(data)
        @message = data[:message]
        @path = data[:path]
        super
      end
    end
  end
end
