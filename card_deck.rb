# frozen_string_literal: true

require_relative 'card'

class CardDeck
  NUMBERS = (2..10).to_a
  PICTURES = %w[J Q K A].freeze
  SUITS = %w[+ <3 ^ <>].freeze

  attr_reader :cards

  def initialize
    @cards = []

    SUITS.each do |suit|
      NUMBERS.each do |number|
        @cards << Card.new(number, suit)
      end
      PICTURES.each do |picture|
        @cards << Card.new(picture, suit)
      end
    end

    @cards.shuffle!
  end
end
