# frozen_string_literal: true

# Advent of Code 2025 Runner

def run_day(day_num) # rubocop:disable Metrics/MethodLength
  ruby_script = "ruby/day_#{day_num}.rb"
  python_script = "python/day_#{day_num}.py"
  elixir_script = "elixir/day_#{day_num}.exs"

  return unless File.exist?(ruby_script) || File.exist?(python_script) || File.exist?(elixir_script)

  puts "\n=== Day #{day_num} ==="

  if File.exist?(ruby_script)
    puts 'Ruby:'
    load ruby_script
  end

  if File.exist?(python_script)
    puts 'Python:'
    system("python3 #{python_script}")
  end

  return unless File.exist?(elixir_script)

  puts 'Elixir:'
  system("elixir #{elixir_script}")
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
