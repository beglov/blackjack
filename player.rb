# frozen_string_literal: true

require_relative 'person'

class Player < Person
  attr_reader :name

  def initialize(name)
    @name = name
    super()
  end
end
