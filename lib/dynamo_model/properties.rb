require 'dynamo_model/property'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/concern'
require 'active_model/attribute_methods'

module DynamoModel

  module Properties
    extend ActiveSupport::Concern
    include ActiveModel::AttributeMethods

    included do
      include ClassMethods
    end

    module ClassMethods
      def property(name, options = {})
        undefine_attribute_methods
        properties[name] = DynamoModel::Property.new(name, options.delete(:default), options)
      end

      def properties
        @properties || {}.with_indifferent_access
      end

      def define_attribute_methods
        super(properties.keys)
      end
    end

    def attributes
      raw_attributes.reject { |k, v| !respond_to?(k) }
    end

    def raw_attributes
      @attributes = @attributes || {}
      self.class.properties.values.inject(@attributes.with_indifferent_access) do |hash, prop|
        hash[prop.key] = attribute(prop.key)
        hash
      end
    end


    # @private
    def method_missing(method, *args, &block)
      self.class.define_attribute_methods
      super
    end

    # @private
    def respond_to?(*args)
      self.class.define_attribute_methods
      super
    end
  end

end
