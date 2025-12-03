defmodule JoltagesFinder do

  def joltages do
    File.read!("joltages.txt")
    |> String.split("\n", trim: true)
  end

  def find_largest_joltage(joltage, num_digits \\ 2) do
    joltage
    |> String.graphemes()
    |> do_find_largest(num_digits, [])
    |> Enum.join()
    |> String.to_integer()
  end

  defp do_find_largest(_chars, 0, acc), do: Enum.reverse(acc)

  defp do_find_largest(chars, digits_needed, acc) do
    search_end = length(chars) - digits_needed + 1

    {max_digit, remaining} =
      chars
      |> Enum.take(search_end)
      |> Enum.max()
      |> then(fn max ->
        {_, [^max | rest]} = Enum.split_while(chars, &(&1 != max))
        {max, rest}
      end)

    do_find_largest(remaining, digits_needed - 1, [max_digit | acc])
  end

  def run do
    joltage_list = joltages()

    IO.puts("=== Day 3: Largest Joltages ===")

    part1_sum =
      joltage_list
      |> Enum.map(&find_largest_joltage(&1, 2))
      |> Enum.sum()

    IO.puts("Part 1 - Sum of largest 2-digit joltages: #{part1_sum}")

    part2_sum =
      joltage_list
      |> Enum.map(&find_largest_joltage(&1, 12))
      |> Enum.sum()

    IO.puts("Part 2 - Sum of largest 12-digit joltages: #{part2_sum}")
  end
end

# Run the solution
JoltagesFinder.run()
