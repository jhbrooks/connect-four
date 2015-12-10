require_relative "./piece.rb"

class State
  attr_reader :players, :board
  attr_accessor :current_player, :last_square

  def initialize(current_player, players, last_square, board)
    @current_player = current_player
    @players = players
    @last_square = last_square
    @board = board
  end

  def win?
    board.win?(last_square)
  end

  def tie?
    !win? && board.full?
  end

  def next_player
    if current_player == players.last
      players.first
    else
      players.last
    end
  end

  def add_piece(h_pos)
    if target = board.add_piece(h_pos, Piece.new(current_player))
      self.last_square = target
    else
      false
    end
  end

  def to_s
    f_string = "\nIt is #{current_player}'s turn to play.\n\n"
    f_string << (board.to_s)
  end
end
