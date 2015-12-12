require_relative "./piece.rb"

# The class handles States of games of Connect Four
class State
  attr_reader :players, :board, :line_width
  attr_accessor :current_player, :last_square

  def initialize(current_player, players, board, last_square, line_width)
    @current_player = current_player
    @players = players
    @board = board
    @last_square = last_square
    self.last_square ||= board.squares.first
    @line_width = line_width
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
    f_string = "\n#{status_string.center(line_width)}\n\n"
    f_string << (board.to_s)
  end

  private

  def status_string
    if win?
      "#{current_player} has won!"
    elsif tie?
      "It's a tie!"
    else
      "It is #{current_player}'s turn to play."
    end
  end
end
