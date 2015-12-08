require "spec_helper"

describe Board do
  let(:empty_board) { Board.create_empty(6, 7) }
  let(:board) { Board.new(6, 7, [:a]) }

  describe ".create_empty" do
    context "when given 2 arguments" do
      it "returns a Board object" do
        expect(empty_board).to be_an_instance_of(Board)
      end

      it "returns an empty object" do
        expect(empty_board.empty?).to be(true)
      end
    end

    context "when given fewer than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Board.create_empty }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Board.create_empty(:a, :b, :c) }.to raise_error(ArgumentError)
      end
    end
  end

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
      expect(board.rows).to eq([:a])
    end
  end
end
