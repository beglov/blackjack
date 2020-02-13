# frozen_string_literal: true

require_relative 'player'
require_relative 'dealer'
require_relative 'card_deck'

class Blackjack
  def initialize(username)
    @player = Player.new(username)
    @dealer = Dealer.new
    game
  end

  private

  attr_reader :player, :dealer, :card_deck

  def game
    continue = true
    while continue && (player.bank.positive? && dealer.bank.positive?)
      start_game
      main_game_loop
      results
      puts 'Если хотите сыграть еще нажмите enter, если хотите выйти напишите exit'
      continue = gets.chomp != 'exit'
    end
  end

  def start_game
    @card_deck = CardDeck.new
    player.cards = card_deck.cards.pop(2)
    dealer.cards = card_deck.cards.pop(2)
    puts
    puts 'Диллер раздал по две карты'
    make_bets
  end

  def make_bets
    bet = 10
    player.bank -= bet
    dealer.bank -= bet
    puts "Размер ставки: #{bet}"
    puts "Размер банка #{player.name}: #{player.bank}"
    puts "Размер банка диллера: #{dealer.bank}"
  end

  def main_game_loop
    loop do
      show_summary

      available_actions = [3]
      available_actions << 1
      available_actions << 2 if player.cards.size < 3

      puts 'Твой ход'
      action = 0
      until available_actions.include?(action)
        puts '1 - Пропустить'
        puts '2 - Добавить карту' if player.cards.size < 3
        puts '3 - Открыть карты'
        action = gets.chomp.to_i
      end

      case action
      when 1
        puts 'Вы пропустили ход'
      when 2
        puts 'Вы взяли карту'
        add_card(player)
      when 3
        puts 'Открываем карты...'
        break
      end

      dealer_turn
    end
  end

  def dealer_turn
    puts
    puts 'Ход диллера...'
    if dealer.score < 17 && dealer.cards.size < 3
      puts 'Берет карту'
      add_card(dealer)
    else
      puts 'Пропускает ход'
    end
  end

  def add_card(who)
    who.cards << card_deck.cards.pop
  end

  def show_summary
    puts
    puts "Карты #{player.name}: #{player.cards.join(', ')}. Сумма очков: #{player.score}"
    puts "Карты диллера: #{'* ' * dealer.cards.size}"
    puts
  end

  def results
    puts
    puts "Карты #{player.name}: #{player.cards.join(', ')}. Сумма очков: #{player.score}."
    puts "Карты диллера: #{dealer.cards.join(', ')}. Сумма очков: #{dealer.score}."

    if player.score == dealer.score
      puts 'Ничья!!! Фишки возвращены!'
      player.bank += 10
      dealer.bank += 10
    elsif player.score > dealer.score
      puts "Выиграл #{player.name}!!! Его банк становится #{player.bank += 20}!"
    else
      puts "Выиграл диллер!!! Его банк становится #{dealer.bank += 20}!"
    end
  end
end
