class State
  attr_reader :board
  attr_accessor :player, :last_square

  def initialize(player, last_square, board)
    @player = player
    @last_square = last_square
    @board = board
  end

  def win?
    board.win?(last_square)
  end

  def tie?
    !win? && board.full?
  end

  def to_s
    f_string = "It is #{player}'s turn to play.\n\n"
    f_string << (board.to_s)
  end
end
