require 'aws/dynamo_db'

module DynamoModel
  class Connection
    def self.create(credentials)
      @_connection = AWS::DynamoDB.new(
        :access_key_id => credentials["access_key"],
        :secret_access_key => credentials["secret_key"]
      )
      return @_connection
    end
  end
end
