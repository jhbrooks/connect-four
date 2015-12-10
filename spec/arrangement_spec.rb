require "spec_helper"

describe Arrangement do
  let(:empty_arrangement) { Arrangement.create_empty(6) }
  let(:arrangement) { Arrangement.new([:a, :b, :c]) }

  describe ".create_empty" do
    context "when given 1 argument" do
      it "returns an Arrangement object" do
        expect(empty_arrangement).to be_an_instance_of(Arrangement)
      end

      it "returns an empty object" do
        expect(empty_arrangement.empty?).to be(true)
      end
    end

    context "when given fewer than 1 argument" do
      it "raises an ArgumentError" do
        expect { Arrangement.create_empty }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 1 argument" do
      it "raises an ArgumentError" do
        expect { Arrangement.create_empty(:a, :b) }
               .to raise_error(ArgumentError)
      end
    end
  end

  describe "#new" do
    context "when given 1 argument" do
      it "returns an Arrangement object" do
        expect(arrangement).to be_an_instance_of(Arrangement)
      end
    end

    context "when given fewer than 1 argument" do
      it "raises an ArgumentError" do
        expect { Arrangement.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 1 argument" do
      it "raises an ArgumentError" do
        expect { Arrangement.new(:a, :b) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#squares" do
    it "returns the correct collection of squares" do
      expect(arrangement.squares).to eq([:a, :b, :c])
    end
  end

  describe "#win?" do
    context "with 4 or more adjacent non-empty squares" do
      context "when those squares are equal" do
        it "returns true" do
          empty_arrangement.add_piece(:b)
          4.times do
            empty_arrangement.add_piece(:a)
          end
          expect(empty_arrangement.win?).to be(true)
        end
      end

      context "when those squares are not equal" do
        it "returns false" do
          2.times do
            empty_arrangement.add_piece(:b)
          end
          3.times do
            empty_arrangement.add_piece(:a)
          end
          expect(empty_arrangement.win?).to be(false)
        end
      end
    end

    context "with fewer than 4 adjacent non-empty squares" do
      it "returns false" do
        3.times do
          empty_arrangement.add_piece(:a)
        end
        expect(empty_arrangement.win?).to be(false)
      end
    end
  end

  describe "#add_piece" do
    context "when the Arrangement is empty" do
      let(:target_square) do
        empty_arrangement.squares[0]
      end

      let(:squares_above) do
        empty_arrangement.squares[1...empty_arrangement.squares.length]
      end

      it "adds a piece to the bottom square" do
        empty_arrangement.add_piece(:a)
        expect(target_square.piece).to eq(:a)
      end

      it "doesn't add a piece to any square above that square" do
        empty_arrangement.add_piece(:a)
        expect(squares_above.all? { |square| square.empty? }).to be(true)
      end

      it "returns true" do
        expect(empty_arrangement.add_piece(:a)).to be(true)
      end
    end

    context "when the Arrangement is partially full" do
      let(:target_square) do
        empty_arrangement.squares[1]
      end

      let(:squares_above) do
        empty_arrangement.squares[2...empty_arrangement.squares.length]
      end

      let(:squares_below) do
        empty_arrangement.squares[0...1]
      end

      before (:each) do
        empty_arrangement.add_piece(:a)
      end

      it "adds a piece to the lowest empty square" do
        empty_arrangement.add_piece(:b)
        expect(target_square.piece).to eq(:b)
      end

      it "doesn't add a piece to any square above that square" do
        empty_arrangement.add_piece(:b)
        expect(squares_above.all? { |square| square.empty? }).to be(true)
      end

      it "doesn't change the piece of any square below that square" do
        empty_arrangement.add_piece(:b)
        expect(squares_below.all? { |square| square.piece == :a }).to be(true)
      end

      it "returns true" do
        expect(empty_arrangement.add_piece(:b)).to be(true)
      end
    end

    context "when the Arrangement is full" do
      before (:each) do
        empty_arrangement.squares.length.times do
          empty_arrangement.add_piece(:a)
        end
      end

      it "doesn't change the piece of any square" do
        empty_arrangement.add_piece(:b)
        expect(empty_arrangement.squares.all? { |square| square.piece == :a })
              .to be(true)
      end

      it "returns false" do
        expect(empty_arrangement.add_piece(:b)).to be(false)
      end
    end
  end
end

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

  describe "#v_pos" do
    it "returns the correct vertical position" do
      expect(row.v_pos).to eq(1)
    end
  end

  describe "#to_s" do
    it "returns a formatted string containing the Row's squares as strings" do
      expect(empty_row.to_s).to eq("||   |   |   |   |   |   |   ||")
    end
  end
end

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
end
