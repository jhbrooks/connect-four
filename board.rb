class Board
  attr_reader :height, :width, :rows

  def initialize(height, width, rows)
    @height = height
    @width = width
    @rows = rows
  end
end
