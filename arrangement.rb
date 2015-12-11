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

  def win?
    non_empty_adjacent_equals = []
    squares.each do |square|
      if square.empty?
        non_empty_adjacent_equals = []
      elsif square != non_empty_adjacent_equals.last
        non_empty_adjacent_equals = [square]
      else
        non_empty_adjacent_equals << square
        return true if non_empty_adjacent_equals.length == 4
      end
    end
    false
  end

  def add_piece(piece)
    if target = squares.find { |square| square.empty? }
      target.piece = piece
      target
    else
      false
    end
  end
end

class Row < Arrangement
  attr_reader :v_pos, :line_width

  def self.create_empty(v_pos, width, line_width)
    squares = []
    width.times do |i|
      squares << (Square.create_empty(i + 1, v_pos))
    end

    self.new(v_pos, squares, line_width)
  end

  def initialize(v_pos, squares, line_width)
    @v_pos = v_pos
    @squares = squares
    @line_width = line_width
  end

  def to_s
    f_string = "|| "
    f_string << (squares.map { |square| square.to_s }.join(" | ").reverse)
    f_string << " ||"
    f_string.center(line_width)
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
