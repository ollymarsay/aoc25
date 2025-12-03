from pathlib import Path


def joltages() -> list[str]:
    """Read joltages from file."""
    input_path = Path(__file__).parent.parent / "joltages.txt"
    with input_path.open() as f:
        return f.read().splitlines()


def find_largest_joltage(joltage: str, num_digits: int = 2) -> int:
    """
    Find the largest number by selecting num_digits from joltage string.
    
    Uses a greedy algorithm: at each position, select the largest digit
    that still leaves enough digits remaining to complete the number.
    """
    chars = list(joltage)
    result = []
    start_pos = 0
    
    for i in range(num_digits):
        remaining_needed = num_digits - i - 1
        search_end = len(chars) - remaining_needed
        
        max_digit = max(chars[start_pos:search_end])
        max_pos = start_pos + chars[start_pos:search_end].index(max_digit)
        
        result.append(max_digit)
        start_pos = max_pos + 1
    
    return int(''.join(result))


if __name__ == "__main__":
    joltage_list = joltages()
    
    print("=== Day 3: Largest Joltages ===")
    part1_sum = sum(find_largest_joltage(j, 2) for j in joltage_list)
    print(f"Part 1 - Sum of largest 2-digit joltages: {part1_sum}")
    
    part2_sum = sum(find_largest_joltage(j, 12) for j in joltage_list)
    print(f"Part 2 - Sum of largest 12-digit joltages: {part2_sum}")
