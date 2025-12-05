# frozen_string_literal: true

# Determine which ingredient IDs fall within the specified fresh ranges
def determine_fresh_ingredients(ingredient_ranges, ingredient_ids)
  valid_ranges = ingredient_ranges.map { |line| line.split('-').map(&:to_i) }

  fresh_count = ingredient_ids.count do |id|
    ingredient_value = id.to_i
    valid_ranges.any? { |start, finish| (start..finish).cover?(ingredient_value) }
  end

  puts "Fresh ingredients count: #{fresh_count}"
  fresh_count
end

# Count total fresh IDs by merging overlapping ranges (optimized)
def determine_all_fresh_ids(ingredient_ranges) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  ranges = ingredient_ranges.map { |line| line.split('-').map(&:to_i) }.sort

  merged = ranges.each_with_object([]) do |(start, finish), acc|
    if acc.empty? || start > acc.last[1] + 1
      acc << [start, finish]
    else
      acc.last[1] = [acc.last[1], finish].max
    end
    acc
  end

  total_fresh_ids = merged.sum { |start, finish| finish - start + 1 }

  puts "Total fresh ingredient IDs: #{total_fresh_ids}"
  total_fresh_ids
end

if __FILE__ == $PROGRAM_NAME
  content = File.read('ingredients.txt').strip
  ingredient_ranges, ingredient_ids = content.split("\n\n").map { |section| section.split("\n") }

  determine_fresh_ingredients(ingredient_ranges, ingredient_ids)
  determine_all_fresh_ids(ingredient_ranges)
end
