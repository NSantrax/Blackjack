
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
      a  =  0
	  @hand.each do |card|
	  	if card =~ /^[A]+/
	  	  a  +=1
	  	  @count += 11
	      elsif card.to_i !=  0
	        @count += card.to_i 
	        else
	          @count +=10
	    end
	  end
	    while @count  >  21  &&  a  > 0
	     	@count -=10
	     	a  -=1
	    end
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

    def showdown
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