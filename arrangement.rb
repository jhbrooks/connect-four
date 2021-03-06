# Only required for .create_empty, so only required for testing
require_relative "./square.rb"

# This class handles Arrangements of squares, such as rows or columns.
# An Arrangement's squares should be ordered, with the bottom square first.
class Arrangement
  attr_reader :squares

  # Only required for testing
  def self.create_empty(length)
    squares = []
    length.times do |i|
      squares << (Square.create_empty(length - i, length - i))
    end

    new(squares)
  end

  def initialize(squares)
    @squares = squares
  end

  def empty?
    squares.all?(&:empty?)
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
    if target = squares.find(&:empty?)
      target.piece = piece
      target
    else
      false
    end
  end
end

# This class handles Rows of squares.
# Rows are special because:
# * They have a line width (for display)
# * They have a #to_s method (for display)
#   * #to_s assumes the Row's bottom square is the one on the far right
class Row < Arrangement
  attr_reader :line_width

  # Only required for testing
  def self.create_empty(v_pos, width, line_width)
    squares = []
    width.times do |i|
      squares << (Square.create_empty(i + 1, v_pos))
    end

    new(squares, line_width)
  end

  def initialize(squares, line_width)
    @squares = squares
    @line_width = line_width
  end

  def to_s
    f_string = "|| "
    f_string << (squares.map(&:to_s).join(" | ").reverse)
    f_string << " ||"
    f_string.center(line_width)
  end
end

# This class handles Columns of squares.
# Columns are special because:
# * They have a horizontal position (for piece placement)
class Column < Arrangement
  attr_reader :h_pos

  # Only required for testing
  def self.create_empty(h_pos, height)
    squares = []
    height.times do |i|
      squares << (Square.create_empty(h_pos, i + 1))
    end

    new(h_pos, squares)
  end

  def initialize(h_pos, squares)
    @h_pos = h_pos
    @squares = squares
  end
end
