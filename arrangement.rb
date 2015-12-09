require_relative "./square.rb"

class Arrangement
  attr_reader :squares

  def self.create_empty(length)
    squares = []
    length.times do |i|
      squares << (Square.create_empty(length - i, length - i))
    end

    self.new(squares)
  end

  def initialize(squares)
    @squares = squares
  end

  def empty?
    squares.all? { |square| square.empty? }
  end

  def add_piece(piece)
    if target = squares.find { |square| square.empty? }
      target.piece = piece
      true
    else
      false
    end
  end
end

class Row < Arrangement
  attr_reader :v_pos

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

  def to_s
    f_string = "|| "
    f_string << (squares.map { |square| square.to_s }.join(" | "))
    f_string << " ||"
  end
end

class Column < Arrangement
  attr_reader :h_pos

  def self.create_empty(h_pos, height)
    squares = []
    height.times do |i|
      squares << (Square.create_empty(h_pos, i + 1))
    end

    self.new(h_pos, squares)
  end

  def initialize(h_pos, squares)
    @h_pos = h_pos
    @squares = squares
  end
end
