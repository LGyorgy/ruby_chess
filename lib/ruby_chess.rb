class Board
  attr_reader :layout

  def initialize
    @dim = 8
    @layout = Hash.new {}
    @dim.times { |i| @layout[[i,1]] = WhitePawn }
    @layout[[0,0]] = WhiteRook
    @layout[[7,0]] = WhiteRook
  end

  def get_cell(pos_ary)
    x = pos_ary[0]
    y = pos_ary[1]
    return @layout[[x,y]]
  end
end

class Piece
  @symbol = "?"
  @color = :none

  def self.symbol
    @symbol
  end

  def self.color
    @color
  end
end

class WhitePawn < Piece
  @symbol = "\u265F"
  @color = :white
end

class WhiteRook < Piece
  @symbol = "\u265C"
  @color = :white
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
