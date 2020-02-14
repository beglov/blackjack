# frozen_string_literal: true

module Interface
  module_function

  def ask_player_name
    puts 'Введите имя пользователя:'
    gets.chomp
  end

  def ask_player_decision(player)
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
    action
  end

  def new_round
    puts
    puts 'Диллер раздал по две карты'
  end

  def make_bets(bet, player, dealer)
    puts "Размер ставки: #{bet}"
    puts "Размер банка #{player.name}: #{player.bank}"
    puts "Размер банка диллера: #{dealer.bank}"
  end

  def show_summary(player, dealer)
    puts
    puts "Карты #{player.name}: #{player.cards.join(', ')}. Сумма очков: #{player.score}"
    puts "Карты диллера: #{'* ' * dealer.cards.size}"
    puts
  end

  def skip_turn
    puts 'Вы пропустили ход'
  end

  def take_card
    puts 'Вы взяли карту'
  end

  def open_cards
    puts 'Открываем карты...'
  end

  def dealer_turn
    puts
    puts 'Ход диллера...'
  end

  def dealer_skip_turn
    puts 'Пропускает ход'
  end

  def dealer_take_card
    puts 'Берет карту'
  end

  def show_results_summary(player, dealer)
    puts
    puts "Карты #{player.name}: #{player.cards.join(', ')}. Сумма очков: #{player.score}."
    puts "Карты диллера: #{dealer.cards.join(', ')}. Сумма очков: #{dealer.score}."
  end

  def draw
    puts 'Ничья!!! Фишки возвращены!'
  end

  def player_wins(player)
    puts "Выиграл #{player.name}!!! Его банк становится #{player.bank}!"
  end

  def dealer_wins(dealer)
    puts "Выиграл диллер!!! Его банк становится #{dealer.bank}!"
  end
end
