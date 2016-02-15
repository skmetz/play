gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'spiral'

class SpiralTest < Minitest::Test

  def test_2x2
    data = [%w[a b],
            %w[c d]]

    expected = %w[a b d c]

    assert_equal expected, Spiral.new(data: data).to_s
  end

  def test_4x4
    data = [%w[a b c d],
            %w[e f g h],
            %w[i j k l],
            %w[m n o p]]

    expected = %w[a b c d h l p o n m i e f g k j]

    assert_equal expected, Spiral.new(data: data).to_s
  end

  def test_3x4
    data = [%w[a b c],
            %w[d e f],
            %w[g h i],
            %w[j k l]]

    expected = %w[a b c f i l k j g d e h]

    assert_equal expected, Spiral.new(data: data).to_s
  end

  def test_3x5
    data = [%w[a b c],
            %w[d e f],
            %w[g h i],
            %w[j k l],
            %w[m n o]]

    expected = %w[a b c f i l o n m j g d e h k]

    assert_equal expected, Spiral.new(data: data).to_s
  end

  def test_5x3
    data = [%w[a b c d e],
            %w[f g h i j],
            %w[k l m n o]]

    expected = %w[a b c d e j o n m l k f g h i]

    assert_equal expected, Spiral.new(data: data).to_s
  end

  def test_5x4
    data = [%w[a b c d e],
            %w[f g h i j],
            %w[k l m n o],
            %w[p q r s t]]

    expected = %w[a b c d e j o t s r q p k f g h i n m l]

    assert_equal expected, Spiral.new(data: data).to_s
  end

  def test_2x2_counterclockwise
    data = [%w[a b],
            %w[c d]]

    expected = %w[a c d b]

    assert_equal expected,
                Spiral.new(data: data, direction: :counterclockwise).to_s
  end

  def test_5x4_counterclockwise
    data = [%w[a b c d e],
            %w[f g h i j],
            %w[k l m n o],
            %w[p q r s t]]

    expected = %w[a f k p q r s t o j e d c b g l m n i h]

    assert_equal expected,
                Spiral.new(data: data, direction: :counterclockwise).to_s
  end


  def test_5x4_from_top_right
    data = [%w[a b c d e],
            %w[f g h i j],
            %w[k l m n o],
            %w[p q r s t]]

    expected = %w[e j o t s r q p k f a b c d i n m l g h]

    assert_equal expected,
                Spiral.new(data: data, origin: :top_right).to_s
  end

  def test_5x4_from_bottom_right
    data = [%w[a b c d e],
            %w[f g h i j],
            %w[k l m n o],
            %w[p q r s t]]

    expected = %w[t s r q p k f a b c d e j o n m l g h i]

    assert_equal expected,
                Spiral.new(data: data, origin: :bottom_right).to_s
  end

  def test_5x4_from_bottom_left
    data = [%w[a b c d e],
            %w[f g h i j],
            %w[k l m n o],
            %w[p q r s t]]

    expected = %w[p k f a b c d e j o t s r q l g h i n m]

    assert_equal expected,
                Spiral.new(data: data, origin: :bottom_left).to_s
  end


  def test_5x4_from_bottom_left_counterclockwise
    data = [%w[a b c d e],
            %w[f g h i j],
            %w[k l m n o],
            %w[p q r s t]]

    expected = %w[p q r s t o j e d c b a f k l m n i h g]

    assert_equal expected,
                Spiral.new(data: data,
                                  direction: :counterclockwise,
                                  origin: :bottom_left).to_s
  end

end
