require_relative "./square.rb"
require_relative "./arrangement.rb"

class Board
  attr_reader :width, :height, :squares, :rows, :cols, :diags

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
    @diags = create_diags
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

  def create_diags
    diags = []
    diags << create_down_diags
    diags << create_up_diags
    diags.flatten
  end

  def create_down_diags
    down_diags = []

    width.times do |x|
      h_pos = x + 1
      v_pos = 1
      down_diag_squares = []

      while v_pos.between?(1, height) && h_pos.between?(1, width)
        target_square = squares.find do |square|
          square.h_pos == h_pos && square.v_pos == v_pos
        end
        down_diag_squares << target_square
        h_pos -= 1
        v_pos += 1
      end
      down_diags << (Arrangement.new(down_diag_squares))
    end

    height.times do |y|
      next if y == 0
      h_pos = width
      v_pos = y + 1
      down_diag_squares = []

      while v_pos.between?(1, height) && h_pos.between?(1, width)
        target_square = squares.find do |square|
          square.h_pos == h_pos && square.v_pos == v_pos
        end
        down_diag_squares << target_square
        h_pos -= 1
        v_pos += 1
      end
      down_diags << (Arrangement.new(down_diag_squares))
    end

    down_diags
  end

  def create_up_diags
    up_diags = []

    height.times do |y|
      h_pos = 1
      v_pos = height - y
      up_diag_squares = []

      while v_pos.between?(1, height) && h_pos.between?(1, width)
        target_square = squares.find do |square|
          square.h_pos == h_pos && square.v_pos == v_pos
        end
        up_diag_squares << target_square
        h_pos += 1
        v_pos += 1
      end
      up_diags << (Arrangement.new(up_diag_squares))
    end

    width.times do |x|
      next if x == 0
      h_pos = x + 1
      v_pos = 1
      up_diag_squares = []

      while v_pos.between?(1, height) && h_pos.between?(1, width)
        target_square = squares.find do |square|
          square.h_pos == h_pos && square.v_pos == v_pos
        end
        up_diag_squares << target_square
        h_pos += 1
        v_pos += 1
      end
      up_diags << (Arrangement.new(up_diag_squares))
    end

    up_diags
  end
end
