class State
  attr_reader :board
  attr_accessor :player

  def initialize(player, board)
    @player = player
    @board = board
  end

  def to_s
    f_string = "It is #{player}'s turn to play.\n\n"
    f_string << (board.to_s)
  end
end
