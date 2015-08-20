require_relative 'sokoban'

lines = File.readlines('sokoban_levels.txt')
levels = lines.map {|line| line.chomp.ljust(19)}.join("\n")
levels = levels.split(/\n {19}\n/)

game = Sokoban.for(levels[0])
game.play
