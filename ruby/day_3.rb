# frozen_string_literal: true

def joltages
  File.readlines('joltages.txt', chomp: true)
end

def find_largest_joltage(joltage, num_digits = 2) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  chars = joltage.chars
  result = []
  start_pos = 0

  num_digits.times do |i|
    remaining_needed = num_digits - i - 1
    search_end = chars.length - remaining_needed

    max_digit = chars[start_pos...search_end].max
    max_pos = start_pos + chars[start_pos...search_end].index(max_digit)

    result << max_digit
    start_pos = max_pos + 1
  end

  result.join.to_i
end

puts '=== Day 3: Largest Joltages ==='
puts "Part 1 - Sum of largest 2-digit joltages: #{joltages.map { |joltage| find_largest_joltage(joltage, 2) }.sum}"
puts "Part 2 - Sum of largest 12-digit joltages: #{joltages.map { |joltage| find_largest_joltage(joltage, 12) }.sum}"
