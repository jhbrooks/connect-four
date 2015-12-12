require "spec_helper"

describe State do
  let(:empty_state) do
    p1 = Player.new("P1", "X")
    p2 = Player.new("P2", "O")
    State.new(p1, [p1, p2], Board.create_empty(7, 6, 33), nil, 33)
  end

  let(:state) { State.new(:p1, [:p1, :p2], :b, :c, 0) }

  describe "#new" do
    context "when given 5 arguments" do
      it "returns a State object" do
        expect(state).to be_an_instance_of(State)
      end
    end

    context "when given fewer than 5 arguments" do
      it "raises an ArgumentError" do
        expect { State.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 5 arguments" do
      it "raises an ArgumentError" do
        expect { State.new(:a, :b, :c, :d, :e, :f) }
          .to raise_error(ArgumentError)
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

  describe "#board" do
    it "returns the correct board" do
      expect(state.board).to eq(:b)
    end
  end

  describe "#last_square" do
    it "returns the correct last square" do
      expect(state.last_square).to eq(:c)
    end
  end

  describe "#last_square=" do
    it "correctly sets a new last square" do
      state.last_square = :c2
      expect(state.last_square).to eq(:c2)
    end
  end

  describe "#line_width" do
    it "returns the correct line width" do
      expect(state.line_width).to eq(0)
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

    context "when targetted at a full column" do
      before(:each) do
        empty_state.board.height.times do
          empty_state.add_piece(1)
        end
      end

      it "leaves the last square unchanged" do
        empty_state.add_piece(1)
        expect(empty_state.last_square)
          .to eq(Square.new(1, 6, Piece.new(empty_state.current_player)))
      end

      it "returns false" do
        expect(empty_state.add_piece(1)).to be(false)
      end
    end

    context "when targetted off the board" do
      it "leaves the last square unchanged" do
        empty_state.add_piece(0)
        expect(empty_state.last_square)
          .to be(empty_state.board.squares.first)
      end

      it "returns false" do
        expect(empty_state.add_piece(0)).to be(false)
      end
    end
  end

  describe "#to_s" do
    context "with no win or tie present" do
      it "returns a formatted string representing the State" do
        expect(empty_state.to_s)
          .to eq("\n    It is P1's turn to play.     \n\n"\
                 "   [1] [2] [3] [4] [5] [6] [7]   \n"\
                 " ------------------------------- \n"\
                 " ||   |   |   |   |   |   |   || \n"\
                 " ------------------------------- \n"\
                 " ||   |   |   |   |   |   |   || \n"\
                 " ------------------------------- \n"\
                 " ||   |   |   |   |   |   |   || \n"\
                 " ------------------------------- \n"\
                 " ||   |   |   |   |   |   |   || \n"\
                 " ------------------------------- \n"\
                 " ||   |   |   |   |   |   |   || \n"\
                 " ------------------------------- \n"\
                 " ||   |   |   |   |   |   |   || \n"\
                 " ------------------------------- \n\n")
      end
    end

    context "with a win present" do
      it "returns a formatted string representing the State" do
        empty_state.board.width.times do |x|
          empty_state.board.height.times do
            h_pos = x + 1
            empty_state.board.add_piece(h_pos, :a)
          end
        end
        empty_state.last_square = empty_state.board.squares[5]
        expect(empty_state.to_s)
          .to eq("\n           P1 has won!           \n\n"\
                 "   [1] [2] [3] [4] [5] [6] [7]   \n"\
                 " ------------------------------- \n"\
                 " || a | a | a | a | a | a | a || \n"\
                 " ------------------------------- \n"\
                 " || a | a | a | a | a | a | a || \n"\
                 " ------------------------------- \n"\
                 " || a | a | a | a | a | a | a || \n"\
                 " ------------------------------- \n"\
                 " || a | a | a | a | a | a | a || \n"\
                 " ------------------------------- \n"\
                 " || a | a | a | a | a | a | a || \n"\
                 " ------------------------------- \n"\
                 " || a | a | a | a | a | a | a || \n"\
                 " ------------------------------- \n\n")
      end
    end

    context "with a tie present" do
      it "returns a formatted string representing the State" do
        p1 = Player.new("P1", "X")
        p2 = Player.new("P2", "O")
        empty_state = State.new(p1, [p1, p2],
                                Board.create_empty(7, 6, 39),
                                nil, 39)

        empty_state.board.width.times do |x|
          empty_state.board.height.times do |y|
            h_pos = x + 1
            empty_state.board.add_piece(h_pos, ((10 * x) + y))
          end
        end
        empty_state.last_square = empty_state.board.squares[5]
        expect(empty_state.to_s)
          .to eq("\n              It's a tie!              \n\n"\
                 "      [1] [2] [3] [4] [5] [6] [7]      \n"\
                 "    -------------------------------    \n"\
                 " || 5 | 51 | 52 | 53 | 54 | 55 | 56 || \n"\
                 "    -------------------------------    \n"\
                 " || 4 | 41 | 42 | 43 | 44 | 45 | 46 || \n"\
                 "    -------------------------------    \n"\
                 " || 3 | 31 | 32 | 33 | 34 | 35 | 36 || \n"\
                 "    -------------------------------    \n"\
                 " || 2 | 21 | 22 | 23 | 24 | 25 | 26 || \n"\
                 "    -------------------------------    \n"\
                 " || 1 | 11 | 12 | 13 | 14 | 15 | 16 || \n"\
                 "    -------------------------------    \n"\
                 " || 0 | 01 | 02 | 03 | 04 | 05 | 06 || \n"\
                 "    -------------------------------    \n\n")
      end
    end
  end
end
