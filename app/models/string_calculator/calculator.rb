module StringCalculator
  class Calculator < ::Calculator
    default_scope -> { where(variant: 'string_calculator') }

    DEFAULT_DELIMITER = ",|\n" # Default delimiters
    OPERATIONS = %w[add]

    attr_reader :numbers

    def perform!
      return 0 if input.strip.empty?

      has_valid_operations?

      extract_numbers
      send(operation)
    end

    private

    def add
      return 0 if input.strip.empty?
      if @numbers.present?
        update(result: @numbers.sum)
      end
    end

    def validate_numbers
      # Handle negatives
      raise "Negative input not allowed: #{@numbers}" if has_negatives?
    end

    def extract_numbers
      delimiter = DEFAULT_DELIMITER
      update(input: input.gsub('\n', "\n")) if input.include?('\n')

      parsed_numbers = input
      if input.start_with?("//")
        custom_delimiter, parsed_numbers = parse_custom_delimiter
        delimiter = Regexp.escape(custom_delimiter)
      end

      @numbers ||= parsed_numbers.split(/#{delimiter}/).map(&:to_i)
      validate_numbers
      @numbers
    end

    def has_valid_operations?
      @operation.in?(OPERATIONS)
    end
  
    def has_negatives?
      @numbers.any?(&:negative?)
    end

    def parse_custom_delimiter
      match = input.match(%r{//(.+)\n(.*)})
      [match[1], match[2]]
    end
  end
end
