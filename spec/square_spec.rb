require "spec_helper.rb"

describe Square do
  let(:empty_square) { Square.create_empty(1, 2) }
  let(:square) { Square.new(1, 2, :a) }

  describe ".create_empty" do
    context "when given 2 arguments" do
      it "returns a Square object" do
        expect(empty_square).to be_an_instance_of(Square)
      end

      it "returns an empty object" do
        expect(empty_square.empty?).to be(true)
      end
    end

    context "when given fewer than 2 arguments" do
      it "raises an ArgumentError" do
        expect { Square.create_empty }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 2 argument" do
      it "raises an ArgumentError" do
        expect { Square.create_empty(:a, :b, :c) }
               .to raise_error(ArgumentError)
      end
    end
  end

  describe "#new" do
    context "when given 3 arguments" do
      it "returns a Square object" do
        expect(square).to be_an_instance_of(Square)
      end
    end

    context "when given fewer than 3 arguments" do
      it "raises an ArgumentError" do
        expect { Square.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 3 arguments" do
      it "raises an ArgumentError" do
        expect { Square.new(:a, :b, :c, :d) }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#h_pos" do
    it "returns the correct horizontal position" do
      expect(square.h_pos).to eq(1)
    end
  end

  describe "#v_pos" do
    it "returns the correct vertical position" do
      expect(square.v_pos).to eq(2)
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

    context "when the Square does not have a piece (piece == \" \")" do
      it "returns true" do
        square.piece = " "
        expect(square.empty?).to be(true)
      end
    end
  end

  describe "#==" do
    it "compares using each object's piece" do
      expect(square).to eq(Square.new(2, 3, :a))
    end

    context "when the second object lacks a piece" do
      it "returns false" do
        expect(square == :a).to be(false)
      end
    end
  end

  describe "#to_s" do
    context "when called on a non-empty Square" do
      it "returns the Square's piece as a string" do
        expect(square.to_s).to eq("a")
      end
    end

    context "when called on an empty Square" do
      it "returns a single space" do
        expect(empty_square.to_s).to eq(" ")
      end
    end
  end
end
