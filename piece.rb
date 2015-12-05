class Piece
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def ==(other)
    player == other
  end
end
