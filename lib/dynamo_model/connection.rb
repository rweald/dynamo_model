module DynamoModel
  class Connection
    def self.create(credentials)
      _connection = AWS::DynamoDB.new(
        :access_key_id => credentials["access_key"],
        :secret_access_key => credentials["secret_key"]
      )
      return _connection
    end

    def self.create_from_config
      config = Configuration.load_configuration.config
      config = config[DynamoModel.environment]
      _connection = AWS::DynamoDB.new(
        :access_key_id => config["access_key"],
        :secret_access_key => config["secret_key"]
      )
    end
  end
end
