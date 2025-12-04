# frozen_string_literal: true

require 'matrix'

def warehouse_layout
  Matrix[*File.readlines('warehouse_layout.txt', chomp: true).map(&:chars)]
end

def determine_forklift_access(warehouse_layout) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
  rows = warehouse_layout.row_count
  cols = warehouse_layout.column_count
  current_layout = warehouse_layout.dup
  total_removed = 0

  loop do
    access_matrix = Matrix.build(rows, cols) { false }

    (0...rows).each do |r|
      (0...cols).each do |c|
        # Check if the 8 adjacent cells contain a paper roll '@'
        next unless current_layout[r, c] == '@'

        adjacent_positions = [
          [r - 1, c - 1], [r - 1, c], [r - 1, c + 1],
          [r, c - 1],                 [r, c + 1],
          [r + 1, c - 1], [r + 1, c], [r + 1, c + 1]
        ]
        # if they do, count them up, if <4 then mark this cell as accessible
        paper_roll_count = adjacent_positions.count do |adj_r, adj_c|
          adj_r.between?(0, rows - 1) && adj_c.between?(0, cols - 1) &&
            current_layout[adj_r, adj_c] == '@'
        end

        access_matrix[r, c] = paper_roll_count < 4
      end
    end

    removed_count = access_matrix.count(true)
    break if removed_count.zero?

    total_removed += removed_count

    # Remove paper rolls marked as accessible
    new_rows = current_layout.to_a.map.with_index do |row, r|
      row.map.with_index do |cell, c|
        access_matrix[r, c] ? '.' : cell
      end
    end
    current_layout = Matrix[*new_rows]
  end

  puts total_removed
end

determine_forklift_access(warehouse_layout)
