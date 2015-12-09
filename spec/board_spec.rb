require "spec_helper"

describe Board do
  let(:empty_board) { Board.create_empty(7, 6) }
  let(:board) do
   Board.new(7, 6, [Square.new(1, 1, :a), Square.new(2, 2, :b)])
  end

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

  describe "#squares" do
    it "returns the correct collection of squares" do
      expect(board.squares).to eq([Square.new(1, 1, :a), Square.new(2, 2, :b)])
    end
  end

  describe "#rows" do
    it "returns a collection of rows" do
      expect(board.rows.all? { |row| row.instance_of?(Row) }).to be(true)
    end

    it "returns a collection with length equal to the Board's height" do
      expect(board.rows.length).to eq(6)
    end
  end

  describe "#cols" do
    it "returns a collection of columns" do
      expect(board.cols.all? { |col| col.instance_of?(Column) }).to be(true)
    end

    it "returns a collection with length equal to the Board's width" do
      expect(board.cols.length).to eq(7)
    end
  end

  describe "#diags" do
    it "returns a collection of Arrangements" do
      expect(board.diags.all? { |col| col.instance_of?(Arrangement) })
            .to be(true)
    end

    it "returns a collection of the correct length ((w + h - 1) * 2)" do
      expect(board.diags.length).to eq(24)
    end
  end

  describe "#to_s" do
    it "returns a formatted string containing the Board's rows as strings" do
      expect(empty_board.to_s).to eq("-------------------------------\n"\
                                     "||   |   |   |   |   |   |   ||\n"\
                                     "-------------------------------\n"\
                                     "||   |   |   |   |   |   |   ||\n"\
                                     "-------------------------------\n"\
                                     "||   |   |   |   |   |   |   ||\n"\
                                     "-------------------------------\n"\
                                     "||   |   |   |   |   |   |   ||\n"\
                                     "-------------------------------\n"\
                                     "||   |   |   |   |   |   |   ||\n"\
                                     "-------------------------------\n"\
                                     "||   |   |   |   |   |   |   ||\n"\
                                     "-------------------------------")
    end
  end
end
