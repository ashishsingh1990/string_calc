class StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    # Step 1: Sanitize newlines and escape sequences like '\\n'
    sanitized_numbers = sanitize_newline_params(numbers)

    # Step 2: Parse the sanitized string and return the result
    parsed_numbers = parse_numbers(sanitized_numbers)
    validate_negatives(parsed_numbers)

    parsed_numbers.sum
  end

  private

  # Replace '\\n' (escaped newlines) with an actual newline character
  def self.sanitize_newline_params(numbers)
    numbers.gsub('\\n', "\n") # Replace \\n with actual newline character
  end

  # Method to parse the input string into an array of integers
  def self.parse_numbers(numbers)
    if numbers.start_with?("//[")
      delimiters, numbers = extract_multiple_delimiters(numbers)
      split_numbers(numbers, delimiters)
    elsif numbers.start_with?("//")
      delimiter, numbers = numbers.split("\n", 2)
      delimiter = delimiter[2..-1] # Get the delimiter part
      split_numbers(numbers, [delimiter])
    else
      # Default case: split by commas and newlines (handle both)
      split_numbers(numbers, [',', "\n"])
    end
  end

  # Method to extract multiple delimiters dynamically
  def self.extract_multiple_delimiters(numbers)
    delimiters_part, numbers = numbers.split("\n", 2) # Split only at the first newline
    delimiters = delimiters_part[3..-2] # Remove "//[" and "]"
    delimiters = delimiters.split('][') # Split by '][' to extract multiple delimiters
    [delimiters, numbers]
  end

  # Method to split numbers based on delimiters (comma and newline)
  def self.split_numbers(numbers, delimiters)
    # Join the delimiters and escape them properly for use in Regexp
    regex = Regexp.new(delimiters.map { |d| Regexp.escape(d) }.join('|'))
    
    # Split the numbers by the regex and convert them to integers
    numbers_array = numbers.split(regex).map(&:to_i)
    # Debugging the split result
    #puts "Split Numbers: #{numbers_array}"
    numbers_array
  end

  # Method to validate negative numbers
  def self.validate_negatives(numbers)
    negatives = numbers.select { |n| n < 0 }
    if negatives.any?
      raise "negative numbers not allowed #{negatives.join(',')}"
    end
  end
end
