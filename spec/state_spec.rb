require "spec_helper"

describe State do
  let(:empty_state) do
    p1 = Player.new("P1", "X")
    p2 = Player.new("P2", "O")
    State.new(p1, [p1, p2], nil, Board.create_empty(7, 6))
  end

  let(:state) { State.new(:p1, [:p1, :p2], :b, :c) }

  describe "#new" do
    context "when given 4 arguments" do
      it "returns a State object" do
        expect(state).to be_an_instance_of(State)
      end
    end

    context "when given fewer than 4 arguments" do
      it "raises an ArgumentError" do
        expect { State.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 4 arguments" do
      it "raises an ArgumentError" do
        expect { State.new(:a, :b, :c, :d, :e) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#current_player" do
    it "returns the correct player" do
      expect(state.current_player).to eq(:p1)
    end
  end

  describe "#current_player=" do
    it "correctly sets a new player" do
      state.current_player = :p2
      expect(state.current_player).to eq(:p2)
    end
  end

  describe "#players" do
    it "returns the correct collection of players" do
      expect(state.players).to eq([:p1, :p2])
    end
  end

  describe "#last_square" do
    it "returns the correct last square" do
      expect(state.last_square).to eq(:b)
    end
  end

  describe "#last_square=" do
    it "correctly sets a new last square" do
      state.last_square = :b2
      expect(state.last_square).to eq(:b2)
    end
  end

  describe "#board" do
    it "returns the correct board" do
      expect(state.board).to eq(:c)
    end
  end

  describe "#tie?" do
    context "when the board is not full" do
      it "returns false" do
        empty_state.board.add_piece(1, :a)
        empty_state.last_square = empty_state.board.squares[-6]
        expect(empty_state.tie?).to be(false)
      end
    end

    context "when the board is full" do
      context "with a win present" do
        it "returns false" do
          empty_state.board.width.times do |x|
            empty_state.board.height.times do
              h_pos = x + 1
              empty_state.board.add_piece(h_pos, :a)
            end
          end
          empty_state.last_square = empty_state.board.squares[5]
          expect(empty_state.tie?).to be(false)
        end
      end

      context "with no win present" do
        it "returns true" do
          empty_state.board.width.times do |x|
            empty_state.board.height.times do |y|
              h_pos = x + 1
              empty_state.board.add_piece(h_pos, ((10 * x) + y))
            end
          end
          empty_state.last_square = empty_state.board.squares[5]
          expect(empty_state.tie?).to be(true)
        end
      end
    end
  end

  describe "#next_player" do
    context "when the current player is not the last player in players" do
      it "returns the next player in players" do
        expect(state.next_player).to eq(:p2)
      end
    end

    context "when the current player is the last player in players" do
      it "returns the first player in players" do
        state.current_player = :p2
        expect(state.next_player).to eq(:p1)
      end
    end
  end

  describe "#add_piece" do
    context "when successful" do
      it "correctly updates the last square" do
        empty_state.add_piece(1)
        expect(empty_state.last_square)
              .to eq(Square.new(1, 1, Piece.new(empty_state.current_player)))
      end
    end

    context "when unsuccessful" do
      it "leaves the last square unchanged" do
        empty_state.board.height.times do
          empty_state.add_piece(1)
        end
        empty_state.add_piece(1)
        expect(empty_state.last_square)
              .to eq(Square.new(1, 6, Piece.new(empty_state.current_player)))
      end
    end
  end

  describe "#to_s" do
    it "returns a formatted string representing the State" do
      expect(empty_state.to_s).to eq("\nIt is P1's turn to play.\n\n"\
                                     "-------------------------------\n"\
                                     "||   |   |   |   |   |   |   ||\n"\
                                     "-------------------------------\n"\
                                     "||   |   |   |   |   |   |   ||\n"\
                                     "-------------------------------\n"\
                                     "||   |   |   |   |   |   |   ||\n"\
                                     "-------------------------------\n"\
                                     "||   |   |   |   |   |   |   ||\n"\
                                     "-------------------------------\n"\
                                     "||   |   |   |   |   |   |   ||\n"\
                                     "-------------------------------\n"\
                                     "||   |   |   |   |   |   |   ||\n"\
                                     "-------------------------------\n\n")
    end
  end
end
