require "spec_helper"

describe Row do
  let(:empty_row) { Row.create_empty(1, 7) }
  let(:row) { Row.new(1, [:a, :b, :c]) }

  describe ".create_empty" do
    context "when given 2 arguments" do
      it "returns a Row object" do
        expect(empty_row).to be_an_instance_of(Row)
      end

      it "returns an empty object" do
        expect(empty_row.empty?).to be(true)
      end
    end

    context "when given fewer than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Row.create_empty }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Row.create_empty(:a, :b, :c) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#new" do
    context "when given 2 arguments" do
      it "returns a Row object" do
        expect(row).to be_an_instance_of(Row)
      end
    end

    context "when given fewer than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Row.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Row.new(:a, :b, :c) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#vertical_pos" do
    it "returns the correct vertical position" do
      expect(row.vertical_pos).to eq(1)
    end
  end

  describe "#squares" do
    it "returns the correct collection of squares" do
      expect(row.squares).to eq([:a, :b, :c])
    end
  end

  describe "#add_piece" do
    let(:target_square) do
      empty_row.squares.select do |square|
        square.horizontal_pos == 2
      end.first
    end

    let(:other_squares) do
      empty_row.squares.select do |square|
        square.horizontal_pos != 2
      end
    end

    context "when the target square is empty" do
      it "adds a piece to that square" do
        empty_row.add_piece(2, :a)
        expect(target_square.empty?).to be(false)
      end

      it "doesn't add a piece to any other squares" do
        empty_row.add_piece(2, :a)
        expect(other_squares.all? { |square| square.empty? }).to be(true)
      end

      it "returns true" do
        expect(empty_row.add_piece(2, :a)).to be(true)
      end
    end

    context "when the target square is full" do
      before (:each) do
        empty_row.add_piece(2, :a)
      end

      it "doesn't change that square's piece" do
        empty_row.add_piece(2, :b)
        expect(target_square.piece).to eq(:a)
      end

      it "doesn't add a piece to any other squares" do
        empty_row.add_piece(2, :b)
        expect(other_squares.all? { |square| square.empty? }).to be(true)
      end

      it "returns false" do
        expect(empty_row.add_piece(2, :b)).to be(false)
      end
    end
  end

  describe "#to_s" do
    it "returns a formatted string containing the Row's squares as strings" do
      expect(empty_row.to_s).to eq("||   |   |   |   |   |   |   ||")
    end
  end
end
