require_relative "./row.rb"

class Board
  attr_reader :height, :width, :rows

  def self.create_empty(height, width)
    rows = []
    height.times do |i|
      rows << (Row.create_empty(i + 1, width))
    end

    self.new(height, width, rows)
  end

  def initialize(height, width, rows)
    @height = height
    @width = width
    @rows = rows
  end

  def empty?
    rows.all? { |row| row.empty? }
  end

  def add_piece(horizontal_pos, piece)
    piece_added = false
    vertical_pos = 1
    while piece_added == false && vertical_pos <= height
      target_row = rows.select do |row|
        row.vertical_pos == vertical_pos
      end.first
      piece_added = target_row.add_piece(horizontal_pos, piece)
      vertical_pos += 1
    end
    piece_added
  end

  def to_s
    dash_string = "#{'--' * 2}#{'---' * width}#{'-' * (width - 1)}"
    f_string = "#{dash_string}\n"
    f_string << (rows.map { |row| row.to_s }.join("\n#{dash_string}\n"))
    f_string << "\n#{dash_string}"
  end
end
