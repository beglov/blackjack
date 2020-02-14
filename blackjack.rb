# frozen_string_literal: true

require_relative 'interface'
require_relative 'player'
require_relative 'dealer'
require_relative 'card_deck'

class Blackjack
  MAX_SCORE = 21
  BET = 10

  def initialize(interface = Interface)
    @interface = interface
    initialize_game
    game
  end

  private

  attr_reader :interface, :player, :dealer, :card_deck

  def initialize_game
    name = interface.ask_player_name
    @player = Player.new(name)
    @dealer = Dealer.new
  end

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
    interface.new_round
    make_bets
  end

  def make_bets
    bet = BET
    player.bank -= bet
    dealer.bank -= bet
    interface.make_bets(bet, player, dealer)
  end

  def main_game_loop
    loop do
      interface.show_summary(player, dealer)
      action = interface.ask_player_decision(player)

      case action
      when 1
        interface.skip_turn
      when 2
        interface.take_card
        add_card(player)
      when 3
        interface.open_cards
        break
      end

      dealer_turn
    end
  end

  def dealer_turn
    interface.dealer_turn
    if dealer.score < 17 && dealer.cards.size < 3
      interface.dealer_take_card
      add_card(dealer)
    else
      interface.dealer_skip_turn
    end
  end

  def add_card(who)
    who.cards << card_deck.cards.pop
  end

  def results
    interface.show_results_summary(player, dealer)

    if player.score == dealer.score
      interface.draw
      player.bank += 10
      dealer.bank += 10
    elsif player.score > dealer.score
      player.bank += 20
      interface.player_wins(player)
    else
      dealer.bank += 20
      interface.dealer_wins(dealer)
    end
  end
end
