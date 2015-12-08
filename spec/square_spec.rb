require "spec_helper.rb"

describe Square do
  let(:empty_square) { Square.create_empty(1) }
  let(:square) { Square.new(1, :a) }

  describe ".create_empty" do
    context "when given 1 argument" do
      it "returns a Square object" do
        expect(empty_square).to be_an_instance_of(Square)
      end

      it "returns an empty object" do
        expect(empty_square.empty?).to be(true)
      end
    end

    context "when given fewer than 1 argument" do
      it "raises an ArgumentError" do
        expect { Square.create_empty }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 1 argument" do
      it "raises an ArgumentError" do
        expect { Square.create_empty(:a, :b) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#new" do
    context "when given 2 arguments" do
      it "returns a Square object" do
        expect(square).to be_an_instance_of(Square)
      end
    end

    context "when given fewer than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Square.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Square.new(:a, :b, :c) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#horizontal_pos" do
    it "returns the correct horizontal position" do
      expect(square.horizontal_pos).to eq(1)
    end
  end

  describe "#piece" do
    it "returns the correct piece" do
      expect(square.piece).to eq(:a)
    end
  end

  describe "#piece=" do
    it "correctly sets a new piece" do
      square.piece = :b
      expect(square.piece).to eq(:b)
    end
  end

  describe "#empty?" do
    context "when the Square has a piece" do
      it "returns false" do
        expect(square.empty?).to be(false)
      end
    end

    context "when the Square does not have a piece (piece is nil)" do
      it "returns true" do
        square.piece = nil
        expect(square.empty?).to be(true)
      end
    end
  end

  describe "#==" do
    it "compares using each object's piece" do
      expect(square).to eq(Square.new(2, :a))
    end

    context "when the second object lacks a piece" do
      it "returns false" do
        expect(square == :a).to be(false)
      end
    end
  end
end
