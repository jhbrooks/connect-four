require_relative "./square.rb"
require_relative "./arrangement.rb"

# This class handles Boards for games of Connect Four
class Board
  attr_reader :width, :height, :squares, :line_width, :rows, :cols, :diags

  def self.create_empty(width, height, line_width)
    squares = []
    width.times do |x|
      height.times do |y|
        h_pos = width - x
        v_pos = y + 1
        squares << (Square.create_empty(h_pos, v_pos))
      end
    end

    new(width, height, squares, line_width)
  end

  def initialize(width, height, squares, line_width)
    @width = width
    @height = height
    @squares = squares
    @line_width = line_width
    @rows = create_rows
    @cols = create_cols
    @diags = create_diags
  end

  def empty?
    squares.all?(&:empty?)
  end

  def win?(square)
    row_win?(square) || col_win?(square) || diag_win?(square)
  end

  def full?
    squares.none?(&:empty?)
  end

  def add_piece(h_pos, piece)
    if target_col = cols.find { |col| col.h_pos == h_pos }
      target_col.add_piece(piece)
    else
      false
    end
  end

  def to_s
    f_string = label_string
    f_string << "\n#{dash_string}\n"
    f_string << (rows.reverse.map(&:to_s).join("\n#{dash_string}\n"))
    f_string << "\n#{dash_string}\n\n"
  end

  private

  def create_rows
    rows = []
    height.times do |y|
      v_pos = y + 1
      row_squares = squares.select do |square|
        square.v_pos == v_pos
      end
      rows << (Row.new(v_pos, row_squares, line_width))
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
    down_diags << create_bottom_down_diags
    down_diags << create_right_down_diags
    down_diags.flatten
  end

  def create_bottom_down_diags
    bottom_down_diags = []
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
      bottom_down_diags << (Arrangement.new(down_diag_squares))
    end
    bottom_down_diags
  end

  def create_right_down_diags
    right_down_diags = []
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
      right_down_diags << (Arrangement.new(down_diag_squares))
    end
    right_down_diags
  end

  def create_up_diags
    up_diags = []
    up_diags << create_left_up_diags
    up_diags << create_bottom_up_diags
    up_diags.flatten
  end

  def create_left_up_diags
    left_up_diags = []
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
      left_up_diags << (Arrangement.new(up_diag_squares))
    end
    left_up_diags
  end

  def create_bottom_up_diags
    bottom_up_diags = []
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
      bottom_up_diags << (Arrangement.new(up_diag_squares))
    end
    bottom_up_diags
  end

  def row_win?(square)
    rows.find do |row|
      row.squares.map(&:object_id).include?(square.object_id)
    end.win?
  end

  def col_win?(square)
    cols.find do |col|
      col.squares.map(&:object_id).include?(square.object_id)
    end.win?
  end

  def diag_win?(square)
    target_diags = diags.select do |diag|
      diag.squares.map(&:object_id).include?(square.object_id)
    end
    target_diags.any?(&:win?)
  end

  def label_string
    label_nums = []
    width.times do |x|
      h_pos = x + 1
      label_nums << h_pos
    end
    label_nums.map { |n| "[#{n}]" }.join(" ").center(line_width)
  end

  def dash_string
    "#{'--' * 2}#{'---' * width}#{'-' * (width - 1)}".center(line_width)
  end
end
