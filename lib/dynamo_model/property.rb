module DynamoModel
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
