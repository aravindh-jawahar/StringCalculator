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
      negatives = @numbers.select(&:negative?) # Extract negative numbers
      raise "Negative input not allowed: #{negatives.join(', ')}" if negatives.any?
    end

    def extract_numbers
      delimiter = DEFAULT_DELIMITER
      update(input: input.gsub('\n', "\n")) if input.include?('\n')

      parsed_numbers = input
      if input.start_with?("//")
        update(input: input.gsub(/(?<!\/\/.)\n/, input.match(%r{//(.)\n})[1]))
        custom_delimiter, parsed_numbers = parse_custom_delimiter
        delimiter = Regexp.escape(custom_delimiter) # Escape custom delimiter for regex
      end

      @numbers ||= parsed_numbers.split(/#{delimiter}|,|\n/).map(&:to_i)
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
