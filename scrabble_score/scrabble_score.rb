class Scrabble
  LETTER_VALUES =
    {'A' => 1, 'B' => 3, 'C' => 3, 'D' => 2, 'E' => 1, 'F' => 4, 'G' => 2,
     'H' => 4, 'I' => 1, 'J' => 8, 'K' => 5, 'L' => 1, 'M' => 3, 'N' => 1,
     'O' => 1, 'P' => 3, 'Q' => 10, 'R' => 1,'S' => 1, 'T' => 1, 'U' => 1,
     'V' => 4, 'W' => 4, 'X' => 8, 'Y' => 4, 'Z' => 10}

  def self.score(word)
    new(word).score
  end

  attr_reader :word, :multiplier

  def initialize(word, multiplier = Multiplier.new(1))
    @word       = word.to_s.strip.upcase
    @multiplier = multiplier
  end

  def score
    word.chars.reduce(0) {|total, c| total += LETTER_VALUES[c] } * multiplier.value
  end
end

Multiplier = Struct.new(:value)

# Notes:
# 1) Letter feels like it wants to be a class, but the current spec doesn't
#     seem to justify the added complexity.  If letters had multipliers (i.e.)
#     double or triple letter scores), that would tip me.
#
# 2) While it's possible to express LETTER_VALUES more tersely, I wrote it
#     all out because, hey, why make things more complicated than need be?
#     If 'tell me all the letters that have a score of N' was a requirement,
#     I'd derive the answer from this structure.  Or vice-versa.
#
# 3) I made an API breaking change in the tests because I couldn't bear to
#    inject a symbol :single, :double, or :triple as word score multipliers.
#    I instead inject an instance of a Multiplier object.  It responds to
#    value, and just does the right thing.  This is OO Composition, i.e.,
#    a Scrabble has-a Multiplier. (Probably should be a ScrabbleWord has-a
#    Multiplier).
#
# 4) Notice how, now that Multiplier exists, it could be used as a Letter
#    Multiplier.  How nice is that?  Don't you love OO?
#
# Thanks to everyone who sat near me and reminded me about Ruby things. :-)
