# frozen_string_literal: true

class Person
  attr_accessor :bank, :cards

  def initialize(bank = 100)
    @bank = bank
    @cards = []
  end

  def score
    total = cards.sum(&:score)
    total -= 10 if total > Blackjack::MAX_SCORE && cards.any?(&:ace?)
    total = 0 if total > Blackjack::MAX_SCORE
    total
  end
end
