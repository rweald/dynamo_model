require 'dynamo_model/property'
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

end
