from itertools import accumulate

def determine_safe_password(combinations):
    positions = accumulate(
        combinations,
        lambda pos, r: (pos + (int(r[1:]) if r[0] == 'R' else -int(r[1:]))) % 100,
        initial=50
    )
    times_at_zero = sum(1 for pos in positions if pos == 0)
    print(f"Times at zero: {times_at_zero}")

determine_safe_password(open('day_1/combinations.txt').read().splitlines())

# everytime it passes zero, add one to a counter
def determine_safe_password_method_two(combinations):
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
    
    print(f"Times at zero (method two): {times_at_zero}")
    

determine_safe_password_method_two(open('day_1/combinations.txt').read().splitlines())