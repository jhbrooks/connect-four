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
end
