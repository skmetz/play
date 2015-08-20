require 'forwardable'

###############
# Run this:
#   cd sokoban
#   ruby play.rb
#
# Run the tests:
#   ruby sokoban_test.rb
#
#
# Sokoban.for creates a new Game.
# The public interface for a game is #move.
#
# Game is the central coordinator.
#  it gets injected with a board,
#  knows the default Rules,
#  knows how to convert a compass_direction into a Direction,
#  knows how to ask its Rules for a movement rule for any Direction,
#  forwards some messages to board or rules.
#
# Rules contains a factory which selects the correct movement rule
# for any Direction.
#
# MoveIntoWallRule, MoveIntoOpenishSpaceRule, PushCrateRule apply their rule
# and produce a new board for the game.
#
# Board knows about Coordinate.
# Direction knows about Coordinate.
# Coordinate has no dependencies.
#
# This sokoban solution emphasizes rules over cells/occupants.
# It contains objects that play the role of 'movement rule'.
# For any move it chooses the applicable movement rule based on
# the current contents of the cell to which the human would be moving.
#
# Design Priorities:
#   * Make the rules extremely clear.
#       Each movement rule is basically a procedure
#       which explictly lists the rule.
#   * Make it easy to change a rule.
#       Each rule is independent.  You can change one without fear of
#       breaking another.  You could, for example, make walls push back.
#   * Make it easy to add a new rule.
#       You could easily create a rule to make humans hop over storage.
#   * Don't mutate board state in Game.
#       Game replaces its board as a result of #move.  It doesn't move things
#       around on the board it has, it updates its copy of @board with the
#       result of sending #move.
#
# Design Consequences:
#   * The logic to choose a movement rule is distant from the rules themselves.
#
#   * If a new rule gets created, it must get added to the factory.
#
#   * If a new rules gets created that isn't based on the currect occupant of
#     some cell, the factory as a whole might need to change to take new
#     arguments.
#
#   * If you added a bunch of new rules, the Rules class might get uncomfortably
#     large. This would motivate one to consider promoting some of the constants
#     held in Rules into objects with behavior of their own.
###############


class Sokoban

  def self.for(ascii_board)
    Game.new(Board.for(ascii_board))
  end


  class Game
    extend Forwardable
    delegate [:adjacent_coordinate, :set_occupant, :render] => :board
    def_delegator :board, :clone, :clone_board

    delegate [:human_for, :crate_for, :vacated_for] => :rules

    attr_reader :board, :rules

    def initialize(board, rules=Rules.new)
      @board = board
      @rules = rules
    end

    def play
      until complete?
        puts render
        printf "\n%s\n\n> ", self
        c = gets.strip
        begin
          c.each_char { |c| move(Direction.new(c))}
        rescue InvalidDirection => e
          puts "\nError: #{e}\n\n"
        end
      end

      puts render
      printf "\a\a\aYAY!!!"
      # they might like to play the next level, ya think?
      return true

    rescue Interrupt
      puts "\n\nBye\n\n"
    end

    def move(direction)
      @board = movement_rule_for(direction).new(self).
                 move(coordinate_of_human, direction.relative_movement)
    end

    def complete?
      rules.complete?(board.render)
    end

    def movement_rule_for(direction)
      rules.movement_rule_for(
        board.adjacent_occupant(coordinate_of_human,
                                direction.relative_movement))
    end

    def coordinate_of_human
      board.coordinate_of(rules.human_codes)
    end

    def occupyable?(coordinate)
      rules.occupyable?(board.occupant(coordinate))
    end
  end



  class Rules
    WALL              = '#'
    STORAGE           = '.'
    OPEN              = ' '
    HUMAN             = 'h'
    HUMAN_ON_STORAGE  = 'H'
    CRATE             = 'c'
    CRATE_ON_STORAGE  = 'C'

    def movement_rule_for(occupant)
      case occupant
      when WALL
        MoveIntoWallRule
      when ->(occ) {occupyable?(occ)}
        MoveIntoOpenishSpaceRule
      when ->(occ) {crateish?(occ)}
        PushCrateRule
      end
    end

    def complete?(ascii_board)
      ascii_board.scan(/c/).size == 0
    end

    def human_for(value)
      storageish?(value) ? HUMAN_ON_STORAGE : HUMAN
    end

    def crate_for(value)
      storageish?(value) ? CRATE_ON_STORAGE : CRATE
    end

    def vacated_for(value)
      storageish?(value) ? STORAGE : OPEN
    end

    def storageish?(value)
      [STORAGE, CRATE_ON_STORAGE, HUMAN_ON_STORAGE].include?(value)
    end

    def crateish?(value)
      [CRATE, CRATE_ON_STORAGE].include?(value)
    end

    def occupyable?(value)
      [OPEN, STORAGE].include?(value)
    end

    def human_codes
      [HUMAN, HUMAN_ON_STORAGE]
    end
  end

  class MoveIntoWallRule
    attr_reader :game

    def initialize(game)
      @game  = game
    end

    def move(_, _)
      game.board
    end
  end

  class MoveIntoOpenishSpaceRule
    attr_reader :game

    def initialize(game)
      @game  = game
    end

    def move(human_coord, relative_movement)
      adjacent_coord = game.adjacent_coordinate(human_coord, relative_movement)

      board         = game.clone_board
      human_value   = game.human_for(board[adjacent_coord.x][adjacent_coord.y])
      vacated_value = game.vacated_for(board[human_coord.x][human_coord.y])

      game.set_occupant(adjacent_coord, human_value)
      game.set_occupant(human_coord, vacated_value)

      board
    end
  end


  class PushCrateRule
    attr_reader :game

    def initialize(game)
      @game  = game
    end

    def move(human_coord, relative_movement)
      crate_coord    = game.adjacent_coordinate(human_coord, relative_movement)
      adjacent_coord = game.adjacent_coordinate(crate_coord, relative_movement)

      if occupyable?(adjacent_coord)
        board         = game.clone_board
        crate_value   = game.crate_for(board[adjacent_coord.x][adjacent_coord.y])
        human_value   = game.human_for(board[crate_coord.x][crate_coord.y])
        vacated_value = game.vacated_for(board[human_coord.x][human_coord.y])

        game.set_occupant(adjacent_coord, crate_value)
        game.set_occupant(crate_coord, human_value)
        game.set_occupant(human_coord, vacated_value)
        board
      else
        game.board
      end
    end

    def occupyable?(coordinate)
      game.occupyable?(coordinate)
    end
  end

end



class Board
  include Enumerable
  attr_reader :board

  def self.for(ascii_board)
    new(
      ascii_board.split("\n").collect {|row|
        row.each_char.collect {|char| char}
      })
  end

  def initialize(board)
    @board = board
  end

  def [](x)
    board[x]
  end

  def each(&block)
    board.each(&block)
  end

  def index(&block)
    board.index(&block)
  end

  def set_occupant(coordinate, value)
    board[coordinate.x][coordinate.y] = value
  end

  def occupant(coordinate)
    board[coordinate.x][coordinate.y]
  end

  def adjacent_occupant(coord, relative_movement)
    occupant(adjacent_coordinate(coord, relative_movement))
  end

  def adjacent_coordinate(absolute_coord, relative_movement)
    Coordinate.new(absolute_coord.x + relative_movement.x,
                   absolute_coord.y + relative_movement.y)
  end

  def coordinate_of(targets)
    t = [targets].flatten

    x = board.index {|row| t.any? {|target| row.include?(target)}}
    y = board[x].index {|column| t.any? {|target| column.include?(target)}}
    Coordinate.new(x,y)
  end

  def render
    board.collect {|row| row.join('')}.join("\n")
  end
end


class InvalidDirection < Exception; end;

class Direction
  XREF = {n: [-1,0], s: [1,0], e: [0,1], w: [0,-1]}
  attr_reader :compass_direction

  def initialize(compass_direction)
    @compass_direction = compass_direction
    validate
  end

  def to_s
    "Direction compass_direction: #{compass_direction} relative_movement: #{relative_movement}"
  end

  def relative_movement
    Coordinate.new(XREF[compass_direction.to_sym][0], XREF[compass_direction.to_sym][1])
  end

  def validate
    raise InvalidDirection.new("invalid heading #{compass_direction}") unless valid?
  end

  def valid?
    ['n', 's', 'e', 'w'].include?(compass_direction)
  end
end


Coordinate = Struct.new(:x, :y)
