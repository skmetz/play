module Spiralize
  refine Array do
    def flip(to=:clockwise)
      if to == :clockwise
        self
      else
        self.transpose
      end
    end

    def turn(to=:top_left)
      num_rotations(to).times.inject(self) {|result, n| result.transpose.reverse}
    end

    def num_rotations(to)
      return 0 if to == :top_left
      return 1 if to == :top_right
      return 2 if to == :bottom_right
      return 3 if to == :bottom_left
    end
  end
end

using Spiralize

class Spiral
  attr_reader :normal, :transposed, :spiral
  def initialize(data:, origin: :top_left, direction: :clockwise)
    initial_data = data.turn(origin).flip(direction)

    @normal      = initial_data
    @transposed  = initial_data.transpose

    calculate_spiral
  end

  def to_s
    spiral
  end

  private

  def calculate_spiral
    @spiral = []
    until normal.empty?
      @spiral += flatten_outer_box
      remove_outer_box
    end
  end

  def flatten_outer_box
    return normal.flatten     if row_width_is_1?
    return transposed.flatten if col_width_is_1?

    flatten_four_sided_box
  end

  def flatten_four_sided_box
    last_in_col = normal.first.size     - 1
    last_in_row = transposed.first.size - 1

    (normal.first[0,last_in_col] +
    transposed.last[0,last_in_row] +
    normal.last.reverse[0,last_in_col] +
    transposed.first.reverse[0, last_in_row])
  end

  def row_width_is_1?
    width_is_1?(normal)
  end

  def col_width_is_1?
    width_is_1?(transposed)
  end

  def width_is_1?(data)
    data.first.size == 1
  end

  def remove_outer_box
    if normal[1..-2].empty?
      @normal     = []
      @transposed = []
      return
    end

    @normal     = normal[1..-2].transpose[1..-2].transpose
    @transposed = normal.transpose
  end
end
