require_relative "./state.rb"
require_relative "./board.rb"
require_relative "./player.rb"

class Game
  attr_reader :state

  def self.create_default
    p1 = Player.new("P1", "X")
    p2 = Player.new("P2", "O")

    self.new(State.new(p1, [p1, p2], nil, Board.create_empty(7, 6)))
  end

  def initialize(state)
    @state = state
  end

  def play
    game_over = false
    until game_over == true
      puts state
      puts "Please enter a move."
      move = gets.chomp!.to_i
      state.add_piece(move)
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