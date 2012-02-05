require 'yaml'
module DynamoModel
  class Configuration
    #load the config from a file.
    def self.load_configuration(config_path = "config/dynamo_db.yml")
      config_hash = YAML.load(File.read(config_path))
      self.new(config_hash)
    end

    def initialize(config_hash = {})
      @_config_hash = config_hash
    end

    def config
      @_config_hash
    end
  end
end
