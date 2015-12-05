require "spec_helper"

describe Piece do
  let(:dummy_player) do
    instance_double("Player", name: "a", mark: "\u25C9".encode("utf-8"))
  end

  let(:piece) { Piece.new(dummy_player) }

  describe "#new" do
    context "when given 1 argument" do
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
      expect(piece.player).to eq(dummy_player)
    end
  end

  describe "#==" do
    it "compares using each object's player" do
      expect(Piece.new(:a)).to eq(Piece.new(:a))
    end

    context "when the second object lacks a player" do
      it "returns false" do
        expect(Piece.new(:a) == :a).to be(false)
      end
    end
  end
end
