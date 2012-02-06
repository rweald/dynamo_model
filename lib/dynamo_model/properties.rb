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
      attribute_method_suffix "="
    end

    module ClassMethods
      def property(name, options = {})
        undefine_attribute_methods
        properties[name] = DynamoModel::Property.new(name, options.delete(:default), options)
      end

      def properties
        @properties = @properties || {}.with_indifferent_access
      end

      def define_attribute_methods
        super(properties.keys)
      end
    end

    def attributes
      @attributes || raw_attributes
    end

    def raw_attributes
      @attributes = self.class.properties.values.inject({}) do |hash, prop|
        hash[prop.key] = prop.default_value
        hash
      end.with_indifferent_access
    end

    def [](attr_name)
      attribute(attr_name)
    end

    def []=(attr_name, value)
      self.send(:attribute=, attr_name, value)
    end

    def attribute(attr_name)
      attributes[attr_name]
    end

    def attribute=(attr_name, value)
      if prop = self.class.properties[attr_name]
        @attributes[attr_name] = prop.convert_value(value)
      else
        raise "Invalid Property Value"
      end
    end

    def attribute_method?(attr_name)
      self.class.properties.include?(attr_name)
    end
    
    def method_missing(method, *args, &block)
      self.class.define_attribute_methods
      super
    end

    def respond_to?(*args)
      self.class.define_attribute_methods
      super
    end
  end

end
