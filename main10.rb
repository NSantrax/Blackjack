require_relative './dealer'
require_relative './cards10'
require_relative './exeption'
class Main
  MENU_ACTIONS = { 0 => [:menu, 'МЕНЮ'], 1 => [:game_new, 'НАЧАТЬ НОВУЮ ИГРУ'],
                   2 => [:shuffle, 'НАЧАТЬ НОВЫЙ КОН'], 3 => [:exit, 'ВЫХОД'] }.freeze

  def initialize
    @players  =  []
    @dealer  =  Dealer.new
    @players  <<  @dealer
  end

  def run
    p "BLACKJACK"
    p "Здравствуйте. Напишите свое имя"
    loop do
      @name = gets.chomp.capitalize
      raise ArgumentError if @name  !=  ''
      p "Имя не может отсутствоватью Напишите свое имя"
    end
    rescue
    @player  =  Player.new(@name)
    @players  <<  @player
    #p @players #просмотр игроков
    game_new
    menu
  end
   
  def menu
    p " #{@player.name}! Выберите действие."
    MENU_ACTIONS.each { |key, command| puts "#{key} - #{command[1]}" }
    choice = gets.chomp.to_i
    if MENU_ACTIONS.key?(choice)
      send(MENU_ACTIONS[choice][0])
    else p 'Такой команды не существует'
      menu
    end
  end

  def game_new
    p "Напишите, какое количество колод от 1 до 10 Вы хотите использовать в игре, при вводе других символов игра будет вестись одной колодой."
    deck_number  =  gets.chomp.to_i
    deck_number  =  1 if deck_number  <  1  ||  deck_number  >  10
   # p deck_number # просмотр количества колод
    @deck  = Deck.new(deck_number)
    @players.each {|player|  player.bank_100 }
    p "Новая игра! #{@player.name}, у Вас в банке 100 монет, ставка 10 монет за кон. "
    shuffle
  end

  def shuffle
    @players.each {|player| raise BankError, "У #{player.name} закончились деньги. Начните новую игру" if player.bank == 0 }
    raise DeckError, "В колоде осталось мало карт. Начните новую игру" if @deck.cards.size<18
    con
    rescue BankError =>e
    p e.inspect
    e = nil
    rescue DeckError =>e
    p e.inspect
    e = nil
    menu
  end

  def con
    handing
    add_card
    @players.each { |player| player.much;
                             player.showdown }
    calculation
    menu
    rescue MUCH =>e
    p e.inspect
    e = nil
    @players.each { |player| player.showdown }
    calculation21
    menu
  end

  def handing
    @players.each {|player|  player.hand0;
                             player.hand  <<  @deck.cards.pop(2);
                             player.hand.flatten!;
                             player.much; player.show }
  end

  def calculation21
    stay  if  @player.count  >  21  &&  @dealer.count  >  21
    loss  if  @player.count  >  21
    gain  if  @player.count  <  21
  end

  def loss
    @player.take_bank
    @dealer.add_bank
    p "#{@player.name}, Вы проиграли. У Вас в банке #{@player.bank} "
  end

  def gain
    @player.add_bank
    @dealer.take_bank
    p "#{@player.name}, Вы выиграли. У Вас в банке #{@player.bank} "
  end
  
  def stay
    p "СТЕЙ - ничья "
    p "#{@player.name}, у Вас в банке #{@player.bank} "
  end
 
  def calculation
    stay  if  @player.count  ==  @dealer.count
    loss  if  @player.count  <  @dealer.count
    gain  if  @player.count  >  @dealer.count
  end

  def dealer_add_card
    if @dealer.count  <=  17
      @dealer.hand  <<  @deck.cards.pop
      p "Dealer взял одну карту. Dealer hand:  * * * "
      @dealer.much
      else
        p "Dealer пропускает ход. Dealer hand:  * * "
    end
  end

  def add_card
    p "Если хотите пропустить ход, нажмите 1, взять еще одну карту - 2, вскрыть карты, нажмите - 3"
    @number  =  gets.chomp.to_i
    if @number  ==  2
      @player.hand  <<  @deck.cards.pop
      @player.much
      dealer_add_card
      elsif @number  ==  1
        dealer_add_card
        p "Если хотите взять еще одну карту нажмите 2"
        @number  =  gets.chomp.to_i
        @player.hand  <<  @deck.cards.pop if @number ==  2
        @player.much
      end
  end
end

menu = Main.new
menu.run
