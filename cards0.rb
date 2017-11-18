 
class Cards

  VOLUE = %w[ 2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUIT = %w[* <> V ^].freeze

  def initialize
    @cards  =  []
    VOLUE.each {|volue| SUIT.each {|suit| @cards  <<  (volue+suit) }  }
    shuffle
  end

  def deck
  	@cards
  end

  def shuffle
    @cards.shuffle!
  end
end


