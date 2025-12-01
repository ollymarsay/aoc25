# frozen_string_literal: true

def determine_safe_password(combinations)
  dial_position = 50
  times_at_zero = 0

  combinations.each do |rotation|
    direction = rotation[0]
    distance = rotation[1..].to_i

    dial_position += direction == 'L' ? -distance : distance
    dial_position %= 100

    times_at_zero += 1 if dial_position.zero?
  end

  puts "Times at zero: #{times_at_zero}"
end

determine_safe_password(File.readlines('day_1/combinations.txt', chomp: true))

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def determine_safe_password_method_two(combinations)
  dial_position = 50

  times_at_zero = combinations.sum do |rotation|
    distance = rotation[1..].to_i
    step = rotation[0] == 'L' ? -1 : 1

    count = distance.divmod(100).then do |laps, remaining|
      crosses = !dial_position.zero? && remaining >= (step == 1 ? 100 - dial_position : dial_position)
      laps + (crosses ? 1 : 0)
    end

    dial_position = (dial_position + step * distance) % 100
    count
  end

  puts "Times passes zero: #{times_at_zero}"
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

determine_safe_password_method_two(File.readlines('day_1/combinations.txt', chomp: true))
