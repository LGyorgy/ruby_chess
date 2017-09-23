class Board
  attr_reader :layout

  def initialize
    @layout = Array.new(8) { Array.new(8, nil) }
    8.times { |i| @layout[1][i] = WhitePawn.new }
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

    board.layout.each_with_index do |row, i|
      row_string = "#{i+1} |"
      row.each do |cell|
        row_string << (cell != nil ? "#{cell.symbol} |" : "  |")
      end
      row_string << " #{i+1}"
      render_string = hline + (row_string + "\n") + render_string
    end
    render_string = "   A  B  C  D  E  F  G  H\n" + render_string
    print render_string
  end
end

b = Board.new
GameRender.render_board(b)