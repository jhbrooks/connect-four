require "spec_helper"

describe Piece do
  let(:piece) { Piece.new(:a) }

  describe "#new" do
    context "when given 1 argument (player)" do
      it "returns a Piece object" do
        expect(piece).to be_an_instance_of(Piece)
      end
    end

    context "when given fewer than 1 argument" do
      it "raises an ArgumentError" do
        expect { Piece.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 1 argument" do
      it "raises an ArgumentError" do
        expect { Piece.new(:a, :b) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#player" do
    it "returns the correct player" do
      expect(piece.player).to eq(:a)
    end
  end

  describe "#==" do
    it "compares using each object's player" do
      expect(piece).to eq(Piece.new(:a))
    end

    context "when the second object lacks a player" do
      it "returns false" do
        expect(piece).to_not eq(:a)
      end
    end
  end

  describe "#to_s" do
    it "returns the Piece's player's mark as a string" do
      player = instance_double("Player", mark: :X)
      piece = Piece.new(player)
      expect(piece.to_s).to eq("X")
    end
  end
end
