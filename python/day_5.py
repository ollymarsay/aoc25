from pathlib import Path

def determine_fresh_ingredients(ingredient_ranges: list[str], ingredient_ids: list[str]) -> int:
    """Count ingredient IDs that fall within any of the specified ranges."""
    valid_ranges = []

    for line in ingredient_ranges:
        start, end = map(int, line.split('-'))
        valid_ranges.append((start, end))
    fresh_count = 0
    for ingredient_id in ingredient_ids:
        ingredient_value = int(ingredient_id)
        if any(start <= ingredient_value <= end for start, end in valid_ranges):
            fresh_count += 1
    print(f"Fresh ingredients count: {fresh_count}")
    return fresh_count

def determine_all_fresh_ids(ingredient_ranges: list[str]) -> int:
    """Count the number of fresh ingredients by counting all IDs in the valid ranges."""
    ranges = [tuple(map(int, line.split('-'))) for line in ingredient_ranges]
    ranges.sort()
    merged = []

    for start, end in ranges:
        if merged and start <= merged[-1][1] + 1:
            merged[-1] = (merged[-1][0], max(merged[-1][1], end))
        else:
            merged.append((start, end))
    
    total_fresh_ids = sum(end - start + 1 for start, end in merged)
    print(f"Total fresh ingredient IDs: {total_fresh_ids}")
    return total_fresh_ids
   
if __name__ == "__main__":
    input_path = Path(__file__).parent.parent / "ingredients.txt"
    
    with input_path.open() as f:
        content = f.read().strip()
    
    parts = content.split('\n\n')
    ingredient_ranges = parts[0].split('\n')
    ingredient_ids = parts[1].split('\n')

    determine_fresh_ingredients(ingredient_ranges, ingredient_ids)
    determine_all_fresh_ids(ingredient_ranges)