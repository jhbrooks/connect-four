class Square
  attr_reader :horizontal_pos
  attr_accessor :piece

  def self.create_empty(horizontal_pos)
    self.new(horizontal_pos, nil)
  end

  def initialize(horizontal_pos, piece)
    @horizontal_pos = horizontal_pos
    @piece = piece
  end

  def empty?
    return true if piece.nil?
    false
  end

  def ==(other)
    begin
      piece == other.piece
    rescue(NoMethodError)
      false
    end
  end
end
