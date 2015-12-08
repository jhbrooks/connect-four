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

    context "when the target column is empty" do
      it "adds a piece to the correct row in that column" do
        empty_board.add_piece(2, :a)
        target_row = empty_board.rows.select do |row|
          row.vertical_pos == 1
        end.first
        expect(target_row.empty?).to be(false)
      end

      it "doesn't add a piece to any row above that row" do
        empty_board.add_piece(2, :a)
        rows_above = empty_board.rows.select do |row|
          row.vertical_pos > 1
        end
        expect(rows_above.all? { |row| row.empty? }).to be(true)
      end

      it "returns true" do
        expect(empty_board.add_piece(2, :a)).to be(true)
      end
    end

    context "when the target column is partially full" do
      before (:each) do
        empty_board.add_piece(2, :a)
      end

      it "adds a piece to the correct row in that column" do
        empty_board.add_piece(2, :b)
        target_row = empty_board.rows.select do |row|
          row.vertical_pos == 2
        end.first
        expect(target_row.empty?).to be(false)
      end

      it "doesn't add a piece to any row above that row" do
        empty_board.add_piece(2, :b)
        rows_above = empty_board.rows.select do |row|
          row.vertical_pos > 2
        end
        expect(rows_above.all? { |row| row.empty? }).to be(true)
      end

      it "doesn't change a piece in any row below that row" do
        empty_board.add_piece(2, :b)
        rows_below = empty_board.rows.select do |row|
          row.vertical_pos < 2
        end
        rows_below_squares = rows_below.map do |row|
          row.squares
        end
        squares_below = rows_below_squares.map do |squares|
          squares.select do |square|
            square.horizontal_pos == 2
          end.first
        end
        expect(squares_below.all? { |square| square.piece == :a }).to be(true)
      end

      it "returns true" do
        expect(empty_board.add_piece(2, :b)).to be(true)
      end
    end

    context "when the target column is full" do
      before (:each) do
        empty_board.height.times do
          empty_board.add_piece(2, :a)
        end
      end

      it "doesn't change a piece in any row" do
        empty_board.add_piece(2, :b)
        rows_below = empty_board.rows.select do |row|
          row.vertical_pos < empty_board.height + 1
        end
        rows_below_squares = rows_below.map do |row|
          row.squares
        end
        squares_below = rows_below_squares.map do |squares|
          squares.select do |square|
            square.horizontal_pos == 2
          end.first
        end
        expect(squares_below.all? { |square| square.piece == :a }).to be(true)
      end

      it "returns false" do
        expect(empty_board.add_piece(2, :b)).to be(false)
      end
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
