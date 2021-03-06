require "spec_helper"

describe Board do
  let(:empty_board) { Board.create_empty(7, 6, 33) }
  let(:board) do
    Board.new(7, 6, [Square.new(1, 1, :a), Square.new(2, 2, :b)], 0)
  end

  describe ".create_empty" do
    context "when given 3 arguments (width, height, line_width)" do
      it "returns a Board object" do
        expect(empty_board).to be_an_instance_of(Board)
      end

      it "returns an empty object" do
        expect(empty_board.empty?).to be(true)
      end
    end

    context "when given fewer than 3 arguments" do
      it "raises an ArgumentError" do
        expect { Board.create_empty }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 3 arguments" do
      it "raises an ArgumentError" do
        expect { Board.create_empty(:a, :b, :c, :d) }
          .to raise_error(ArgumentError)
      end
    end
  end

  describe "#new" do
    context "when given 4 arguments (width, height, squares, line_width)" do
      it "returns a Board object" do
        expect(board).to be_an_instance_of(Board)
      end
    end

    context "when given fewer than 4 arguments" do
      it "raises an ArgumentError" do
        expect { Board.new }.to raise_error(ArgumentError)
      end
    end

    context "when given more than 4 arguments" do
      it "raises an ArgumentError" do
        expect { Board.new(:a, :b, :c, :d, :e) }.to raise_error(ArgumentError)
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

  describe "#line_width" do
    it "returns the correct line width" do
      expect(board.line_width).to eq(0)
    end
  end

  describe "#rows" do
    it "returns a collection of Rows" do
      expect(board.rows.all? { |row| row.instance_of?(Row) }).to be(true)
    end

    it "returns a collection with length equal to the Board's height" do
      expect(board.rows.length).to eq(6)
    end
  end

  describe "#cols" do
    it "returns a collection of Columns" do
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

  describe "#win?" do
    context "with a row win present" do
      it "returns true" do
        2.upto(5) do |h_pos|
          empty_board.add_piece(h_pos, :a)
        end
        target_square = empty_board.squares[12]
        expect(empty_board.win?(target_square)).to be(true)
      end
    end

    context "with a column win present" do
      it "returns true" do
        4.times do
          empty_board.add_piece(2, :a)
        end
        target_square = empty_board.squares[-9]
        expect(empty_board.win?(target_square)).to be(true)
      end
    end

    context "with a diagonal win present" do
      context "when that diagonal points down" do
        it "returns true" do
          3.times do |i|
            5.upto(7 - i) do |h_pos|
              empty_board.add_piece(h_pos, :a)
            end
            empty_board.add_piece(4, :b)
          end
          empty_board.add_piece(4, :a)
          target_square = empty_board.squares[-21]
          expect(empty_board.win?(target_square)).to be(true)
        end
      end

      context "when that diagonal points up" do
        it "returns true" do
          3.times do |i|
            (i + 1).upto(3) do |h_pos|
              empty_board.add_piece(h_pos, :a)
            end
            empty_board.add_piece(4, :b)
          end
          empty_board.add_piece(4, :a)
          target_square = empty_board.squares[-21]
          expect(empty_board.win?(target_square)).to be(true)
        end
      end
    end

    context "with no win present" do
      it "returns false" do
        target_square = empty_board.squares[1]
        expect(empty_board.win?(target_square)).to be(false)
      end
    end
  end

  describe "#full?" do
    context "when the Board is empty" do
      it "returns false" do
        expect(empty_board.full?).to be(false)
      end
    end

    context "when the Board is partially full" do
      it "returns false" do
        empty_board.add_piece(2, :a)
        expect(empty_board.full?).to be(false)
      end
    end

    context "when the Board is full" do
      it "returns true" do
        empty_board.width.times do |x|
          empty_board.height.times do
            h_pos = x + 1
            empty_board.add_piece(h_pos, :a)
          end
        end
        expect(empty_board.full?).to be(true)
      end
    end
  end

  describe "#add_piece" do
    context "when targetted at a full column" do
      it "returns false" do
        empty_board.height.times do
          empty_board.add_piece(1, :a)
        end
        expect(empty_board.add_piece(1, :a)).to be(false)
      end
    end

    context "when targetted off the board" do
      it "returns false" do
        expect(empty_board.add_piece(0, :a)).to be(false)
      end
    end
  end

  describe "#to_s" do
    context "when the Board is empty" do
      it "returns a formatted string representing the Board" do
        expect(empty_board.to_s).to eq("   [1] [2] [3] [4] [5] [6] [7]   \n"\
                                       " ------------------------------- \n"\
                                       " ||   |   |   |   |   |   |   || \n"\
                                       " ------------------------------- \n"\
                                       " ||   |   |   |   |   |   |   || \n"\
                                       " ------------------------------- \n"\
                                       " ||   |   |   |   |   |   |   || \n"\
                                       " ------------------------------- \n"\
                                       " ||   |   |   |   |   |   |   || \n"\
                                       " ------------------------------- \n"\
                                       " ||   |   |   |   |   |   |   || \n"\
                                       " ------------------------------- \n"\
                                       " ||   |   |   |   |   |   |   || \n"\
                                       " ------------------------------- \n\n")
      end
    end

    context "when the Board is not empty" do
      it "returns a formatted string representing the Board" do
        empty_board.add_piece(1, :a)
        empty_board.add_piece(1, :a)
        empty_board.add_piece(2, :a)
        expect(empty_board.to_s).to eq("   [1] [2] [3] [4] [5] [6] [7]   \n"\
                                       " ------------------------------- \n"\
                                       " ||   |   |   |   |   |   |   || \n"\
                                       " ------------------------------- \n"\
                                       " ||   |   |   |   |   |   |   || \n"\
                                       " ------------------------------- \n"\
                                       " ||   |   |   |   |   |   |   || \n"\
                                       " ------------------------------- \n"\
                                       " ||   |   |   |   |   |   |   || \n"\
                                       " ------------------------------- \n"\
                                       " || a |   |   |   |   |   |   || \n"\
                                       " ------------------------------- \n"\
                                       " || a | a |   |   |   |   |   || \n"\
                                       " ------------------------------- \n\n")
      end
    end
  end
end
