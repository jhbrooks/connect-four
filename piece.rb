# This class handles Pieces
class Piece
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def ==(other)
    if other.methods.include?(:player)
      player == other.player
    else
      false
    end
  end

  # Requires player object to have the #mark method
  def to_s
    "#{player.mark}"
  end
end
