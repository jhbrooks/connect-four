require_relative "./row.rb"
require_relative "./column.rb"

class Board
  attr_reader :width, :height, :squares, :rows, :cols

  def self.create_empty(width, height)
    squares = []
    width.times do |x|
      height.times do |y|
        h_pos = x + 1
        v_pos = y + 1
        squares << (Square.create_empty(h_pos, v_pos))
      end
    end

    self.new(width, height, squares)
  end

  def initialize(width, height, squares)
    @width = width
    @height = height
    @squares = squares
    @rows = create_rows
    @cols = create_cols
  end

  def empty?
    rows.all? { |row| row.empty? }
  end

  def add_piece(h_pos, piece)
    target_col = cols.select do |col|
      col.h_pos == h_pos
    end.first
    target_col.add_piece(piece)
  end

  def to_s
    dash_string = "#{'--' * 2}#{'---' * width}#{'-' * (width - 1)}"
    f_string = "#{dash_string}\n"
    f_string << (rows.map { |row| row.to_s }.join("\n#{dash_string}\n"))
    f_string << "\n#{dash_string}"
  end

  private

  def create_rows
    rows = []
    height.times do |y|
      v_pos = y + 1
      row_squares = squares.select do |square|
        square.v_pos == v_pos
      end
      rows << (Row.new(v_pos, row_squares))
    end
    rows
  end

  def create_cols
    cols = []
    width.times do |x|
      h_pos = x + 1
      col_squares = squares.select do |square|
        square.h_pos == h_pos
      end
      cols << (Column.new(h_pos, col_squares))
    end
    cols
  end
end
