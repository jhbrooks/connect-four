require "spec_helper"

describe Piece do
  let(:dummy_player) do
    instance_double("Player", name: "a", mark: "\u25C9".encode("utf-8"))
  end

  let(:piece) do  
    Piece.new(dummy_player)
  end

  describe "#new" do
    context "when given 1 argument" do
      it "returns a Piece object" do
        expect(piece).to be_an_instance_of(Piece)
      end
    end

    context "when given less than 1 argument" do
      it "raises an ArgumentError" do
        expect{ Piece.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 1 argument" do
      it "raises an ArgumentError" do
        expect{ Piece.new(:a, :b) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#player" do
    it "returns the correct player" do
      expect(piece.player).to eq(dummy_player)
    end
  end

  describe "#==" do
    it "compares using the Piece's player" do
      expect(piece == dummy_player).to be(true)
    end
  end
end