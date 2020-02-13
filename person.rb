# frozen_string_literal: true

class Person
  attr_accessor :bank, :cards

  def initialize(bank = 100)
    @bank = bank
    @cards = []
  end

  def score
    total = cards.sum(&:score)
    total -= 10 if total > 21 && cards.any?(&:ace?)
    total = 0 if total > 21
    total
  end
end
