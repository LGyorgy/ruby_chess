class Board
  attr_reader :layout, :valid_coords

  def initialize
    @dim = 8
    @valid_coords = []

    8.times do |i|
      8.times do |j|
        @valid_coords << [i,j]
      end
    end

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
  attr_reader :symbol, :color

  def initialize(board)
    @symbol = "?"
    @color = :white
    @board = board
  end

  def pos
    @board.layout.key(self)
  end

  def move(to)
    if valid_moves.include?(to)
      move_piece(to)
      return true
    end
    return false
  end

  def valid_moves
    valid_moves_ary = []
    @board.valid_coords.each do |at_pos|
      valid_moves_ary << at_pos if check_collision(at_pos) < 1
    end
    return valid_moves_ary
  end

  def move_piece(to)
    @board.layout.delete(pos)
    @board.layout[to] = self
  end

  def check_collision(at_pos)
    cell = @board.layout[at_pos]
    if cell
      return -1 if cell.color != @color
      return 1 if cell.color == @color
    end
    return 0
  end
end

class DummyPiece < Piece
  def initialize(board)
    super
    @symbol = "O"
    @color = :black
  end
end

class WhitePawn < Piece
  def initialize(board)
    super
    @symbol = "\u265F"
    @color = :white
    @first_move = true
  end

  def move_piece(to)
    @first_move = false
    super
  end

  def valid_moves
    cur_pos = pos
    valid_pos =[]
    
    pos_to_check = [cur_pos[0], cur_pos[1]+1]
    if check_collision(pos_to_check) == 0
      valid_pos << pos_to_check
    end

     pos_to_check = [cur_pos[0], cur_pos[1]+2]
    if check_collision(pos_to_check) == 0 && @first_move
      valid_pos << pos_to_check
    end
    
     pos_to_check = [cur_pos[0]-1, cur_pos[1]+1]
    if check_collision(pos_to_check) == -1
      valid_pos << pos_to_check
    end

     pos_to_check = [cur_pos[0]+1, cur_pos[1]+1]
    if check_collision(pos_to_check) == -1
      valid_pos << pos_to_check
    end
    return valid_pos
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

class Game
  def initialize
    @board = Board.new
    start
  end

  def start
    loop do
      GameRender.render_board(@board)
      move_piece
    end
  end

  def move_piece
    input = get_input
    from = []
    to = []

    from[0] = ("a".."h").to_a.index(input[0])
    from[1] = input[1].to_i - 1

    to[0] = ("a".."h").to_a.index(input[2])
    to[1] = input[3].to_i - 1

    if @board.layout[from]
      @board.layout[from].move(to)
    end
  end

  def get_input
    input = ""
    loop do
      puts "give me input"
      input = gets.chomp.downcase
      break if valid_input?(input)
    end
    return input
  end

  def valid_input?(input)
    return false if input.length != 4
    return false unless ('a'..'h').include?(input[0]) && ('a'..'h').include?(input[2])
    return false unless (1..8).include?(input[1].to_i) && (1..8).include?(input[1].to_i)
    return true
  end

end

Game.new