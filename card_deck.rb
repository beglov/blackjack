# frozen_string_literal: true

require_relative 'card'

class CardDeck
  NUMBERS = (2..10).to_a
  PICTURES = %w[J Q K A].freeze
  SUITS = %w[♠ ♥ ♣ ♦].freeze

  attr_reader :cards

  def initialize
    @cards = []
    SUITS.each do |suit|
      NUMBERS.each { |number| @cards << Card.new(number, suit) }
      PICTURES.each { |picture| @cards << Card.new(picture, suit) }
    end
    @cards.shuffle!
  end
end
