# frozen_string_literal: true

# Advent of Code 2025 Runner
# Usage: ruby runner.rb [day_number]
# Examples:
#   ruby runner.rb       # Run all days
#   ruby runner.rb 1     # Run only day 1

def run_day(day_num) # rubocop:disable Metrics/MethodLength
  day_dir = "day_#{day_num}"
  ruby_script = "#{day_dir}/ruby/day_#{day_num}.rb"
  python_script = "#{day_dir}/python/day_#{day_num}.py"

  return unless File.exist?(ruby_script) || File.exist?(python_script)

  puts "\n=== Day #{day_num} ==="

  if File.exist?(ruby_script)
    puts 'Ruby:'
    load ruby_script
  end

  return unless File.exist?(python_script)

  puts 'Python:'
  system("python3 #{python_script}")
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
