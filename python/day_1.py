from itertools import accumulate
from pathlib import Path


def determine_safe_password(combinations: list[str]) -> int:
    """Count times position reaches zero using accumulate."""
    positions = accumulate(
        combinations,
        lambda pos, r: (pos + (int(r[1:]) if r[0] == 'R' else -int(r[1:]))) % 100,
        initial=50
    )
    times_at_zero = sum(1 for pos in positions if pos == 0)
    print(f"Part One - Times at zero: {times_at_zero}")
    return times_at_zero


def determine_safe_password_method_two(combinations: list[str]) -> int:
    """Count every time position passes zero, including complete loops."""
    position = 50
    times_at_zero = 0
    
    for r in combinations:
        distance = int(r[1:])
        direction = 1 if r[0] == 'R' else -1
        
        # Calculate how many complete loops (times crossing zero)
        laps = distance // 100
        remaining = distance % 100
        
        # Check if the remaining movement crosses zero
        new_position = (position + direction * distance) % 100
        crosses_zero = (
            position != 0 and 
            remaining >= (100 - position if direction == 1 else position)
        )
        
        times_at_zero = times_at_zero + laps + (1 if crosses_zero else 0)
        position = new_position
    
    print(f"Part Two - Times at zero (method two): {times_at_zero}")
    return times_at_zero


if __name__ == "__main__":
    input_path = Path(__file__).parent.parent / "combinations.txt"
    
    with input_path.open() as f:
        combinations = f.read().splitlines()
    
    determine_safe_password(combinations)
    determine_safe_password_method_two(combinations)
