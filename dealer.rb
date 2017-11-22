
class Dealer
  def initialize
    @name  = Dealer
    @bank  =  0
    @hand  =  []
    @count  =  0
  end

  def hand
    @hand
  end

  def hand0
    @hand  =  []
  end

  def bank_100
    @bank  =  100
  end

  def add_bank
    @bank +=10
  end

  def take_bank
    @bank -=10
  end

  def bank
    @bank
  end

  def name
    @name
  end

  def count
    @count  =  0
    @hand.each do |card|
	         @count  +=  1  if card =~ /^[A]+/
	         @count  +=  card.to_i 
                 @count  +=  10  if card =~ /^[JQK]+/
               end
    @count  +=  10  if @count  <  12  &&  @hand.find { |card| card =~ /^[A]+/ }
    @count
  end

  def much 
    count
    raise MUCH,"#{@name}! Вы набрали #{@count} очков - ПЕРЕБОР! Вы проиграли." if @count  >  21
  end

  def show
    count
    p "Dealer hand: * * "
  end

  def showd@bank  =  0
    count
    print "#{@name}  hand: #{@hand} - #{@count} очков \n "
  end
end

class Player < Dealer
  def initialize(name)
    @name  =  name
    @bank  =  0
    @hand  =  []
    @count  =  0
  end

  def show
    count
    print "#{@name}  hand: #{@hand} - #{@count} очков \n "
  end
end
