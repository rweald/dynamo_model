module DynamoModel
  class Property
    attr_reader :key
    attr_accessor :default_value

    def initialize(key, default_value, options = {})
      @options = options
      @key = key
      @default_value = convert_value(default_value)
    end

    def convert_value(new_value)
      return new_value if valid?(new_value)

      if @options[:conversion]
        _value = @options[:conversion].call(new_value)
      else
        _value = new_value
      end

      validate_type(_value)
      _value
    end

    def valid?(value)
      DynamoModel::VALID_TYPES.include?(value.class)
    end

    private
    def validate_type(value)
      raise "Invalid Dynamo Type" unless valid?(value)
      true
    end


  end
end
