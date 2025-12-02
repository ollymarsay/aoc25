import csv
from pathlib import Path


def repeating_pattern(number: int) -> bool:
    """Check if number is made of two identical halves (part one logic)."""
    s = str(number)
    if len(s) % 2 != 0:
        return False
    mid = len(s) // 2
    return s[:mid] == s[mid:]


def repeated_sequence(number: int) -> bool:
    """Check if number is made of any pattern repeated at least twice."""
    s = str(number)
    length = len(s)
    
    for pattern_length in range(1, length // 2 + 1):
        if length % pattern_length != 0:
            continue
        
        is_match = True
        for i in range(pattern_length, length):
            if s[i] != s[i % pattern_length]:
                is_match = False
                break
        
        if is_match:
            return True
    
    return False


def part_one(ranges: list[str]) -> int:
    """Sum all numbers that match the repeating pattern."""
    total = sum(
        num
        for range_str in ranges
        for start, end in [range_str.split('-')]
        for num in range(int(start), int(end) + 1)
        if repeating_pattern(num)
    )
    print(f"Part One - Total sum of invalid combinations: {total}")
    return total


def part_two(ranges: list[str]) -> int:
    """Sum all numbers that are made of repeated sequences."""
    total = sum(
        num
        for range_str in ranges
        for start, end in [range_str.split('-')]
        for num in range(int(start), int(end) + 1)
        if repeated_sequence(num)
    )
    print(f"Part Two - Total sum of invalid combinations: {total}")
    return total


if __name__ == "__main__":
    input_path = Path(__file__).parent.parent / "product_lines.csv"
    
    with input_path.open() as f:
        ranges = next(csv.reader(f))
    
    part_one(ranges)
    part_two(ranges)
