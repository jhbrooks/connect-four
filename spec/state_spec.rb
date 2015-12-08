require "spec_helper"

describe State do
  let(:state) { State.new(:a, :b) }

  describe "#new" do
    context "when given 2 arguments" do
      it "returns a State object" do
        expect(state).to be_an_instance_of(State)
      end
    end

    context "when given fewer than 2 arguments" do
      it "raises an ArgumentError" do
        expect { State.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 2 arguments" do
      it "raises an ArgumentError" do
        expect { State.new(:a, :b, :c) }.to raise_error(ArgumentError)
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
      state.player = :c
      expect(state.player).to eq(:c)
    end
  end

  describe "#board" do
    it "returns the correct board" do
      expect(state.board).to eq(:b)
    end
  end

  describe "#to_s" do
    it "returns a formatted string representing the game state" do
      state = State.new(Player.new("I", "X"), Board.create_empty(6, 7))
      expect(state.to_s).to eq("It is I's turn to play.\n\n"\
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
