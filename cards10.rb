
class Deck
  VOLUE = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUIT = %w[* <> V ^].freeze

  def initialize(deck_number)
    @cards = []
    VOLUE.each { |volue| SUIT.each { |suit| @cards << (volue + suit) } }
    @cards *= deck_number
    shuffle
  end

  attr_reader :cards

  def shuffle
    @cards.shuffle!
  end
end
