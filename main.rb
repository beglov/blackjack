# frozen_string_literal: true

require_relative 'blackjack'

puts 'Введите имя:'
name = gets.chomp

Blackjack.new(name)
