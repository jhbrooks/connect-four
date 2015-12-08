require_relative "./square.rb"

class Row
  attr_reader :vertical_pos, :squares

  def self.create_empty(vertical_pos, width)
    squares = []
    width.times do |i|
      squares << (Square.create_empty(i + 1))
    end

    self.new(vertical_pos, squares)
  end

  def initialize(vertical_pos, squares)
    @vertical_pos = vertical_pos
    @squares = squares
  end

  def empty?
    squares.all? { |square| square.empty? }
  end
end
