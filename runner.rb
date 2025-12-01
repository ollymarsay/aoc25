# frozen_string_literal: true

# Advent of Code 2025 Runner
# Usage: ruby runner.rb [day_number]
# Examples:
#   ruby runner.rb       # Run all days
#   ruby runner.rb 1     # Run only day 1

def run_day(day_num)
  day_dir = "day_#{day_num}"
  script = "#{day_dir}/day_#{day_num}.rb"

  return unless File.exist?(script)

  puts "\n=== Day #{day_num} ==="
  load script
end

if ARGV.empty?
  # Run all days
  (1..25).each do |day|
    run_day(day)
  end
else
  # Run specific day
  run_day(ARGV[0].to_i)
end
