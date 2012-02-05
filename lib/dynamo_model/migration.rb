require 'dynamo_model/connection'
require 'dynamo_model/configuration'

module DynamoModel
  module Migrations
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods
      def create_dynamo_table(name, capacity_units = {})
        read_capacity = capacity_units[:read_capacity] || 5
        write_capacity = capacity_units[:write_capacity] || 5
        DynamoModel::Migration.new.create_table(name.to_s, read_capacity, write_capacity)
      end

      def delete_dynamo_table(name)

      end
    end
  end

  class Migration

    def initialize
      @_connection = Connection.create_from_config
    end

    def create_table(name, read_capacity, write_capacity)
      @_connection.tables.create(name, read_capacity, write_capacity)
    end

  end
end
