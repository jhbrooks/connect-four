require "spec_helper"

describe Board do
  let(:board) { Board.new(6, 7, [1]) }

  describe "#new" do
    context "when given 3 arguments" do
      it "returns a Board object" do
        expect(board).to be_an_instance_of(Board)
      end
    end

    context "when given fewer than 3 arguments" do
      it "raises an ArgumentError" do
        expect { Board.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 3 arguments" do
      it "raises an ArgumentError" do
        expect { Board.new(:a, :b, :c, :d) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#height" do
    it "returns the correct height" do
      expect(board.height).to eq(6)
    end
  end

  describe "#width" do
    it "returns the correct width" do
      expect(board.width).to eq(7)
    end
  end

  describe "#rows" do
    it "returns the correct collection of rows" do
      expect(board.rows).to eq([1])
    end
  end
end
