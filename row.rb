require_relative "./square.rb"

class Row
  attr_reader :v_pos, :squares

  def self.create_empty(v_pos, width)
    squares = []
    width.times do |i|
      squares << (Square.create_empty(i + 1, v_pos))
    end

    self.new(v_pos, squares)
  end

  def initialize(v_pos, squares)
    @v_pos = v_pos
    @squares = squares
  end

  def empty?
    squares.all? { |square| square.empty? }
  end

  def to_s
    f_string = "|| "
    f_string << (squares.map { |square| square.to_s }.join(" | "))
    f_string << " ||"
  end
end
