# This is a port of the example listed at http://rubyquiz.com/quiz5.html.
# I made a few small changes to make it run under Ruby 2.x.
# There are no tests.
#
# run this via
#   cd sokoban/example
#   ruby sokoban.rb

class Level
  def initialize(level)
    @level = level
  end

  def play
    while count_free_crates > 0
      printf "\n%s\n\n> ", self
      c = gets
      c.each_char do |command|
        case command
        when "n"
          move(0, -1)
        when "w"
          move(-1, 0)
        when "s"
          move(0, 1)
        when "e"
          move(1, 0)
        when "r"
          return false
        end
      end
    end

    printf "\n%s\nCongratulations, on to the next level!\n", self
    return true
  end

private

  def move(dx, dy)
    x, y = find_player
    dest = self[x+dx, y+dy]
    case dest
    when "#"
        return
      when 'o', '*'
        dest2 = self[x+dx*2, y+dy*2]
        if dest2 == ' '
          self[x+dx*2, y+dy*2] = 'o'
        elsif dest2 == '.'
          self[x+dx*2, y+dy*2] = '*'
        else
          return
        end
        dest = (dest == 'o') ? ' ' : '.'
    end
    self[x+dx, y+dy] = (dest == ' ') ? '@' : '+'
    self[x, y] = (self[x, y] == '@') ? ' ' : '.'
  end

  def count_free_crates
    @level.scan(/o/).size
  end

  def find_player
    pos = @level.index(/@|\+/)
    return pos % 19, pos / 19
  end

  def [](x, y)
    @level[x + y * 19]
  end

  def []=(x, y, v)
    @level[x + y * 19] = v
  end

  def to_s
    (0...16).map {|i| @level[i * 19, 19]}.join("\n")
  end
end

levels = File.readlines('sokoban_example_levels.txt')
levels = levels.map {|line| line.chomp.ljust(19)}.join("\n")
levels = levels.split(/\n {19}\n/).map{|level| level.gsub(/\n/, '')}

levels.each do |level|
  redo unless Level.new(level.ljust(19*16)).play
end
