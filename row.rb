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

  def add_piece(horizontal_pos, piece)
    target_square = squares.select do |square|
      square.horizontal_pos == horizontal_pos
    end.first
    if target_square.empty?
      target_square.piece = piece
      true
    else
      false
    end
  end

  def to_s
    f_string = "|| "
    f_string << (squares.map { |square| square.to_s }.join(" | "))
    f_string << " ||"
  end
end
