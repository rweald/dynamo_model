require 'aws/dynamo_db'
require 'dynamo_model/version'
require 'dynamo_model/configuration'
require 'dynamo_model/connection'
require 'dynamo_model/migration'

module DynamoModel
  def self.environment
    if defined?(Rails)
      Rails.env
    else
      ENV["DYNAMO_ENV"] || "development"
    end
  end
end
