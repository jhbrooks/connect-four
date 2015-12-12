require_relative "./state.rb"
require_relative "./board.rb"
require_relative "./player.rb"

# The class handles Games of Connect Four
class Game
  attr_reader :state

  def self.create_default
    p1 = Player.new("P1", "X")
    p2 = Player.new("P2", "O")

    new(State.new(p1, [p1, p2], Board.create_empty(7, 6, 80), nil, 80))
  end

  def initialize(state)
    @state = state
  end

  def play
    game_over = false
    until game_over
      puts state
      move_valid = false
      until move_valid
        puts "Please enter a move."
        move = gets.chomp!.to_i
        move_valid = state.add_piece(move)
        puts "Invalid move! Please try again.\n\n" unless move_valid
      end
      if state.win?
        game_over = true
        puts state
      elsif state.tie?
        game_over = true
        puts state
      else
        state.current_player = state.next_player
      end
    end
  end
end
