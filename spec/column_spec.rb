require "spec_helper"

describe Column do
  let(:empty_col) { Column.create_empty(1, 6) }
  let(:col) { Column.new(1, [:a, :b, :c]) }

  describe ".create_empty" do
    context "when given 2 arguments" do
      it "returns a Column object" do
        expect(empty_col).to be_an_instance_of(Column)
      end

      it "returns an empty object" do
        expect(empty_col.empty?).to be(true)
      end
    end

    context "when given fewer than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Column.create_empty }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Column.create_empty(:a, :b, :c) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#new" do
    context "when given 2 arguments" do
      it "returns a Column object" do
        expect(col).to be_an_instance_of(Column)
      end
    end

    context "when given fewer than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Column.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Column.new(:a, :b, :c) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#h_pos" do
    it "returns the correct horizontal position" do
      expect(col.h_pos).to eq(1)
    end
  end

  describe "#squares" do
    it "returns the correct collection of squares" do
      expect(col.squares).to eq([:a, :b, :c])
    end
  end

  describe "#add_piece" do
    context "when the Column is empty" do
      let(:target_square) do
        empty_col.squares.select do |square|
          square.v_pos == 1
        end.first
      end

      let(:squares_above) do
        empty_col.squares.select do |square|
          square.v_pos > 1
        end
      end

      it "adds a piece to the bottom square" do
        empty_col.add_piece(:a)
        expect(target_square.piece).to eq(:a)
      end

      it "doesn't add a piece to any square above that square" do
        empty_col.add_piece(:a)
        expect(squares_above.all? { |square| square.empty? }).to be(true)
      end

      it "returns true" do
        expect(empty_col.add_piece(:a)).to be(true)
      end
    end

    context "when the Column is partially full" do
      let(:target_square) do
        empty_col.squares.select do |square|
          square.v_pos == 2
        end.first
      end

      let(:squares_above) do
        empty_col.squares.select do |square|
          square.v_pos > 2
        end
      end

      let(:squares_below) do
        empty_col.squares.select do |square|
          square.v_pos < 2
        end
      end

      before (:each) do
        empty_col.add_piece(:a)
      end

      it "adds a piece to the lowest empty square" do
        empty_col.add_piece(:b)
        expect(target_square.piece).to eq(:b)
      end

      it "doesn't add a piece to any square above that square" do
        empty_col.add_piece(:b)
        expect(squares_above.all? { |square| square.empty? }).to be(true)
      end

      it "doesn't change the piece of any square below that square" do
        empty_col.add_piece(:b)
        expect(squares_below.all? { |square| square.piece == :a }).to be(true)
      end

      it "returns true" do
        expect(empty_col.add_piece(:b)).to be(true)
      end
    end

    context "when the Column is full" do
      before (:each) do
        empty_col.squares.length.times do
          empty_col.add_piece(:a)
        end
      end

      it "doesn't change the piece of any square" do
        empty_col.add_piece(:b)
        expect(empty_col.squares.all? { |square| square.piece == :a })
              .to be(true)
      end

      it "returns false" do
        expect(empty_col.add_piece(:b)).to be(false)
      end
    end
  end
end
