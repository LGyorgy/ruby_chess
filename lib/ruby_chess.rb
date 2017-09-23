class Board
  attr_reader :layout

  def initialize
    @layout = Array.new(8) { Array.new(8, nil) }
    8.times { |i| @layout[i][1] = WhitePawn.new }
  end

  def get_cell(x,y)
    return @layout[x][y]
  end
end

class WhitePawn
  attr_reader :symbol, :color

  def initialize
    @symbol = "\u265F"
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
        cell = board.layout[x][y]

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
p b.get_cell(1,1)
p b.get_cell(1,3)