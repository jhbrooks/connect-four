class Row
  attr_reader :vertical_pos, :squares

  def initialize(vertical_pos, squares)
    @vertical_pos = vertical_pos
    @squares = squares
  end
end
