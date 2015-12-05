class Piece
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def ==(other)
    begin
      player == other.player
    rescue(NoMethodError)
      false
    end
  end
end
