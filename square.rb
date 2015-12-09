class Square
  attr_reader :h_pos, :v_pos
  attr_accessor :piece

  def self.create_empty(h_pos, v_pos)
    self.new(h_pos, v_pos, " ")
  end

  def initialize(h_pos, v_pos, piece)
    @h_pos = h_pos
    @v_pos = v_pos
    @piece = piece
  end

  def empty?
    return true if piece == " "
    false
  end

  def ==(other)
    begin
      piece == other.piece
    rescue(NoMethodError)
      false
    end
  end

  def to_s
    "#{piece}"
  end
end
