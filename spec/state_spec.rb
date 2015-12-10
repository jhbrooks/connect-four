require "spec_helper"

describe State do
  let(:empty_state) do
    State.new(Player.new("I", "X"), nil, Board.create_empty(7, 6))
  end

  let(:state) { State.new(:a, :b, :c) }

  describe "#new" do
    context "when given 3 arguments" do
      it "returns a State object" do
        expect(state).to be_an_instance_of(State)
      end
    end

    context "when given fewer than 3 arguments" do
      it "raises an ArgumentError" do
        expect { State.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 3 arguments" do
      it "raises an ArgumentError" do
        expect { State.new(:a, :b, :c, :d) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#player" do
    it "returns the correct player" do
      expect(state.player).to eq(:a)
    end
  end

  describe "#player=" do
    it "correctly sets a new player" do
      state.player = :d
      expect(state.player).to eq(:d)
    end
  end

  describe "#last_square" do
    it "returns the correct last square" do
      expect(state.last_square).to eq(:b)
    end
  end

  describe "#last_square=" do
    it "correctly sets a new last square" do
      state.last_square = :d
      expect(state.last_square).to eq(:d)
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
        empty_state.last_square = (Square.new(1, 1, :a))
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
          empty_state.last_square = (Square.new(7, 6, :a))
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
          empty_state.last_square = (Square.new(7, 6, 65))
          expect(empty_state.tie?).to be(true)
        end
      end
    end
  end

  describe "#to_s" do
    it "returns a formatted string representing the State" do
      expect(empty_state.to_s).to eq("It is I's turn to play.\n\n"\
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
                                     "-------------------------------")
    end
  end
end
