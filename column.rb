require_relative "./square.rb"

class Column
  attr_reader :h_pos, :squares

  def self.create_empty(h_pos, height)
    squares = []
    height.times do |i|
      squares << (Square.create_empty(h_pos, i + 1))
    end

    self.new(h_pos, squares)
  end

  def initialize(h_pos, squares)
    @h_pos = h_pos
    @squares = squares
  end

  def empty?
    squares.all? { |square| square.empty? }
  end

  def add_piece(piece)
    piece_added = false
    v_pos = 1
    while piece_added == false && v_pos <= squares.length
      target_square = squares.select do |square|
        square.v_pos == v_pos
      end.first
      if target_square.empty?
        target_square.piece = piece
        piece_added = true
      else
        piece_added = false
        v_pos += 1
      end
    end
    piece_added
  end
end
