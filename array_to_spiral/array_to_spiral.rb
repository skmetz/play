class ArrayToSpiral
  attr_reader :initial_data, :normal, :transposed, :origin, :spiral
  def initialize(data:, origin: :top_left, direction: :clockwise)

    @initial_data = set_initial_data(data, direction, origin)

    @normal     = initial_data
    @transposed = initial_data.transpose

    @origin = origin
    calculate_spiral
  end

  def to_s
    spiral
  end

  private

  def set_initial_data(data, direction, origin)
    transpose(rotate(data, num_rotations(origin)), direction)
  end

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
    last_in_col = normal.first.size - 1
    last_in_row = transposed.first.size - 1

    (normal.first[0,last_in_col] +
    transposed.last[0,last_in_row] +
    normal.last.reverse[0,last_in_col] +
    transposed.first.reverse[0, last_in_row])
  end

  def row_width_is_1?
    normal.first.size == 1
  end

  def col_width_is_1?
    transposed.first.size == 1
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

  def rotate(data, num_times)
    num_times.times.inject(data) {|result, n| result.transpose.reverse}
  end

  def transpose(data, direction)
    if direction == :clockwise
      data
    else
      data.transpose
    end
  end

  def num_rotations(origin)
    return 0 if origin == :top_left
    return 1 if origin == :top_right
    return 2 if origin == :bottom_right
    return 3 if origin == :bottom_left
  end

end
