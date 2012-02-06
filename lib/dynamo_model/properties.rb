require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/concern'
require 'active_model/attribute_methods'

module DynamoModel

  #module Properties
    #extend ActiveSupport::Concern

    #included do
      #include ClassMethods
    #end

    #module ClassMethods
      #def property(name, options = {})
        #value = options[:default] || nil
        #properties[name] = options[:default] || nil
      #end

      #def properties
        #@_properties || {}.with_indifferent_access
      #end
    #end
  #end

  class Property
    attr_reader :key
    attr_accessor :value

    def initialize(key, value, options = {})
      @key = key
      @value = value
      if options[:conversion]
        @value = options[:conversion].call(@value)
      end
      @options = options
      validate_type
    end

    def value=(new_value)
      if @options[:conversion]
      @value = @options[:conversion].call(new_value)
      else
        @value = new_value
      end
      validate_type
    end

    private
    def validate_type
      raise "Invalid Dynamo Type" unless DynamoModel::VALID_TYPES.include?(@value.class)
    end

  end
end
