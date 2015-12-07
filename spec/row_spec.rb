require "spec_helper"

describe Row do
  let(:row) { Row.new(1, [1]) }

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
      expect(row.squares).to eq([1])
    end
  end
end
