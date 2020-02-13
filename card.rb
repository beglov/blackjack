# frozen_string_literal: true

class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def ace?
    value == 'A'
  end

  def picture?
    CardDeck::PICTURES.include?(value)
  end

  def score
    return 11 if ace?
    return 10 if picture?

    value
  end

  def to_s
    "#{value}#{suit}"
  end
end
