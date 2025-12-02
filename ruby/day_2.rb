# frozen_string_literal: true

require 'csv'

def repeating_pattern?(number)
  str = number.to_s
  return false if str.length.odd?

  str[0, str.length / 2] == str[str.length / 2..]
end

def part_one(ranges)
  total = ranges.sum do |range|
    min, max = range.split('-').map(&:to_i)
    (min..max).sum { |num| repeating_pattern?(num) ? num : 0 }
  end

  puts "Total sum of all invalid combinations: #{total}"
end

part_one(CSV.read('product_lines.csv').first)

def repeated_sequence?(number) # rubocop:disable Metrics/MethodLength
  str = number.to_s
  length = str.length

  # Try all possible pattern lengths from 1 to length/2
  (1..length / 2).each do |pattern_length|
    # Check if the string length is divisible by pattern length
    next unless (length % pattern_length).zero?

    # Check if every character matches the pattern without creating new strings
    is_repeating = true
    (0...length).each do |i|
      if str[i] != str[i % pattern_length]
        is_repeating = false
        break
      end
    end

    return true if is_repeating
  end

  false
end

def part_two(ranges)
  total = ranges.sum do |range|
    min, max = range.split('-').map(&:to_i)
    (min..max).sum { |num| repeated_sequence?(num) ? num : 0 }
  end

  puts "Part Two - Total sum of all invalid combinations: #{total}"
end

part_two(CSV.read('product_lines.csv').first)
