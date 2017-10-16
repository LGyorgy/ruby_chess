class Board
  attr_reader :layout

  def initialize
    @dim = 8
    @layout = Hash.new {}
    @dim.times { |i| create_piece([i,1], WhitePawn) }
    create_piece([0,0], WhiteRook)
    create_piece([7,0], WhiteRook)
    create_piece([4,5], DummyPiece)
  end

  def create_piece(coord, piece)
    @layout[coord] = piece.new(self)
  end
  
  def get_cell(pos_ary)
    @layout[pos_ary]
  end
end

class Piece
  attr_reader :symbol

  def initialize(board)
    @symbol = "?"
    @color = :none
    @board = board
  end

  def pos
    @board.layout.key(self)
  end
end

class DummyPiece < Piece
  def initialize(board)
    super
    @symbol = "X"
    @color = :white
  end
end

class WhitePawn < Piece
  def initialize(board)
    super
    @symbol = "\u265F"
    @color = :white
  end
end

class WhiteRook < Piece
  def initialize(board)
    super
    @symbol = "\u265C"
    @color = :white
  end
end

class GameRender
  
  def self.render_board(board)
    hline = "  +--+--+--+--+--+--+--+--+\n"
    render_string = hline + "   A  B  C  D  E  F  G  H\n"

    8.times do |y|
      row_string = "#{y+1} |"

      8.times do |x|
        cell = board.get_cell([x,y])

        row_string << (cell != nil ? "#{cell.symbol} |" : "  |")
      end

      row_string << " #{y+1}"
      render_string = hline + (row_string + "\n") + render_string
    end

    render_string = "   A  B  C  D  E  F  G  H\n" + render_string
    print render_string
  end
end

b = Board.new
GameRender.render_board(b)
