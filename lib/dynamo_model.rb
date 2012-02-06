require 'aws/dynamo_db'
require 'dynamo_model/version'
require 'dynamo_model/configuration'
require 'dynamo_model/connection'
require 'dynamo_model/migration'
require 'dynamo_model/properties'

module DynamoModel
  VALID_TYPES = [String, Integer, Float, Fixnum, Array]

  def self.environment
    if defined?(Rails)
      Rails.env
    else
      ENV["DYNAMO_ENV"] || "development"
    end
  end

end
