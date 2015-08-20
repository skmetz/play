gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'sokoban'

class SokobanTest < Minitest::Test

  def test_walls_are_impassible
    @initial_board = %q[
###
#h#
###].strip

    game = Sokoban.for(@initial_board)
    game.move(Direction.new('e'))
    assert_equal @initial_board, game.render
  end

  def test_can_move_to_open_space
    @initial_board = %q[
####
# h#
####].strip

    @final_board = %q[
####
#h #
####].strip

    game = Sokoban.for(@initial_board)
    game.move(Direction.new('w'))
    assert_equal @final_board, game.render
  end

  def  test_can_move_to_storage
    @initial_board = %q[
####
# .#
# h#
####].strip

    @final_board = %q[
####
# H#
#  #
####].strip

    game = Sokoban.for(@initial_board)
    game.move(Direction.new('n'))
    assert_equal @final_board, game.render
  end

  def  test_can_move_from_storage_to_open_space
    @initial_board = %q[
####
# H#
#  #
####].strip

    @final_board = %q[
####
# .#
# h#
####].strip

    game = Sokoban.for(@initial_board)
    game.move(Direction.new('s'))
    assert_equal @final_board, game.render
  end

  def  test_can_push_crate_to_open_space
    @initial_board = %q[
#####
# ch#
#####].strip

    @final_board = %q[
#####
#ch #
#####].strip

    game = Sokoban.for(@initial_board)
    game.move(Direction.new('w'))
    assert_equal @final_board, game.render
  end

  def test_cannot_push_crate_into_wall
    @initial_board = %q[
#####
#ch #
#####].strip

    @final_board = %q[
#####
#ch #
#####].strip

    game = Sokoban.for(@initial_board)
    game.move(Direction.new('w'))
    assert_equal @final_board, game.render
  end

  def test_cannot_push_crate_into_crate
    @initial_board = %q[
######
# cch#
######].strip

    @final_board = %q[
######
# cch#
######].strip

    game = Sokoban.for(@initial_board)
    game.move(Direction.new('w'))
    assert_equal @final_board, game.render
  end

  def  test_can_push_crate_from_open_space_to_storage
    @initial_board = %q[
####
# .#
# c#
# h#
####].strip

    @final_board = %q[
####
# C#
# h#
#  #
####].strip

    game = Sokoban.for(@initial_board)
    game.move(Direction.new('n'))
    assert_equal @final_board, game.render
  end

  def  test_can_push_crate_from_storage_to_storage
    @initial_board = %q[
#####
#  h#
#  C#
#  .#
#####].strip

    @final_board = %q[
#####
#   #
#  H#
#  C#
#####].strip

    game = Sokoban.for(@initial_board)
    game.move(Direction.new('s'))
    assert_equal @final_board, game.render
  end

  def  test_can_push_crate_from_storage_to_storage_while_on_storage
    @initial_board = %q[
#####
#.CH#
#####].strip

    @final_board = %q[
#####
#CH.#
#####].strip

    game = Sokoban.for(@initial_board)
    game.move(Direction.new('w'))
    assert_equal @final_board, game.render
  end

  def  test_can_push_crate_from_storage_to_open_space
    @initial_board = %q[
#####
# Ch#
#####].strip

    @final_board = %q[
#####
#cH #
#####].strip

    game = Sokoban.for(@initial_board)
    game.move(Direction.new('w'))
    assert_equal @final_board, game.render
  end

  def  test_can_push_crate_from_storage_to_open_space_while_on_storage
    @initial_board = %q[
#####
# CH#
#####].strip

    @final_board = %q[
#####
#cH.#
#####].strip

    game = Sokoban.for(@initial_board)
    game.move(Direction.new('w'))
    assert_equal @final_board, game.render
  end

end
