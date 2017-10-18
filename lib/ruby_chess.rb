class Board
  attr_reader :layout, :valid_coords
  attr_accessor :enpassant_target, :captured_pieces

  def initialize
    @dim = 8
    @valid_coords = []

    8.times do |i|
      8.times do |j|
        @valid_coords << [i,j]
      end
    end

    @layout = Hash.new {}
    @enpassant_target = Hash.new
    @captured_pieces = {white: [],
                        black: []}

    @dim.times do |i|
      create_piece(Pawn, :white, [i,1])
      create_piece(Pawn, :black, [i,6])
    end

    create_piece(Rook, :white, [0,0])
    create_piece(Rook, :white, [7,0])
    create_piece(Rook, :black, [0,7])
    create_piece(Rook, :black, [7,7])
    
    create_piece(Bishop, :white, [2,0])
    create_piece(Bishop, :white, [5,0])
    create_piece(Bishop, :black, [2,7])
    create_piece(Bishop, :black, [5,7])

    create_piece(Knight, :white, [1,0])
    create_piece(Knight, :white, [6,0])
    create_piece(Knight, :black, [1,7])
    create_piece(Knight, :black, [6,7])
    
    create_piece(King, :white, [4,0])
    create_piece(King, :black, [4,7])

    create_piece(Queen, :white, [3,0])
    create_piece(Queen, :black, [3,7])
  end

  def create_piece(piece, color, coord)
    @layout[coord] = piece.new(self, color)
  end

  def reset_enpassant(color_to_reset)
    @enpassant_target[color_to_reset] = []
  end

  def remove_piece(piece)
    @layout.delete(@layout.key(piece))
  end

  def get_cell(pos_ary)
    @layout[pos_ary]
  end
end

class Piece
  attr_reader :symbol, :color

  def initialize(board, color)
    @symbol_pool = ["X", "O"]
    @color = color
    choose_symbol    
    @board = board
    @first_move = true
  end

  def choose_symbol
    if @color == :white
      @symbol = @symbol_pool[0]
    elsif @color == :black
      @symbol = @symbol_pool[1]
    else
      @symbol = "?"
    end
  end

  def enemy
    @color == :white ? :black : :white
  end

  def pos
    @board.layout.key(self)
  end

  def move(to)
    if valid_moves.include?(to)
      if check_collision(to) == -1
        capture(to)
      end
      move_piece(to)
      @first_move = false
      return true
    end
    return false
  end

  def capture(target)
    @board.layout[target].get_captured
  end

  def get_captured
    @board.captured_pieces[@color] << self
    @board.remove_piece(self)
  end

  def valid_moves
    valid_moves_ary = []
    @board.valid_coords.each do |at_pos|
      valid_moves_ary << at_pos if check_collision(at_pos) < 1
    end
    return valid_moves_ary
  end
  
  def linear_movement(offset_ary)
    cur_pos = pos
    valid_moves_ary = []

    offset_ary.each do |offset|
      pos_to_check = [cur_pos[0] + offset[0], cur_pos[1] + offset[1]]
      loop do
        break if !@board.valid_coords.include?(pos_to_check) 
        collision = check_collision(pos_to_check)
        valid_moves_ary << pos_to_check if collision < 1
        break if collision != 0
        pos_to_check = [pos_to_check[0] + offset[0], pos_to_check[1] + offset[1]]
      end
    end

    return valid_moves_ary
  end

  def single_movement(offset_ary)
    cur_pos = pos
    valid_moves_ary = []

    offset_ary.each do |offset|
      pos_to_check = [cur_pos[0] + offset[0], cur_pos[1] + offset[1]]
      valid_moves_ary << pos_to_check if @board.valid_coords.include?(pos_to_check) && check_collision(pos_to_check) < 1
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

class Pawn < Piece
  def initialize(board, color)
    super
    @symbol_pool = ["\u265F", "\u2659"]
    choose_symbol
  end
  
  def move(to)
    return true if enpassant(to)
    super
  end

  def enpassant(target)
    enpassant_target = @board.enpassant_target[enemy]
    if enpassant_target && enpassant_target[0] == target
      enpassant_target[1].get_captured
      move_piece(target)
    end 
  end

  def valid_moves
    cur_pos = pos
    valid_pos =[]
    
    if @color == :black
      black_modifier = -1
    else
      black_modifier = 1
    end

    pos_to_check = [cur_pos[0], cur_pos[1]+(1*black_modifier)]
    if check_collision(pos_to_check) == 0
      valid_pos << pos_to_check
    end

     pos_to_check = [cur_pos[0], cur_pos[1]+(2*black_modifier)]
    if check_collision(pos_to_check) == 0 && @first_move
      valid_pos << pos_to_check
      @board.enpassant_target[@color] = [[cur_pos[0], cur_pos[1]+(1*black_modifier)], self]
    end
    
     pos_to_check = [cur_pos[0]-1, cur_pos[1]+(1*black_modifier)]
    if check_collision(pos_to_check) == -1 || @board.enpassant_target[enemy] == pos_to_check
      valid_pos << pos_to_check
    end

     pos_to_check = [cur_pos[0]+1, cur_pos[1]+(1*black_modifier)]
    if check_collision(pos_to_check) == -1 || @board.enpassant_target[enemy] == pos_to_check
      valid_pos << pos_to_check
    end
    return valid_pos
  end
end

class Rook < Piece
  def initialize(board, color)
    super
    @symbol_pool = ["\u265C", "\u2656"]
    choose_symbol
  end

  def valid_moves
    cur_pos = pos
    offset_ary = [[1,0],[0,1],[-1,0],[0,-1]]
    
    return linear_movement(offset_ary)
  end
end

class Bishop < Piece
  def initialize(board, color)
    super
    @symbol_pool = ["\u265D", "\u2657"]
    choose_symbol
  end

  def valid_moves
    offset_ary = [[1,1],[-1,1],[-1,-1],[1,-1]]
    
    return linear_movement(offset_ary)
  end
end

class Knight < Piece
  def initialize(board, color)
    super
    @symbol_pool = ["\u265E", "\u2658"]
    choose_symbol
  end

  def valid_moves
    offset_ary = [[2,1],[-2,1],[2,-1],[-2,-1],[1,2],[-1,2],[1,-2],[-1,-2]]

    return single_movement(offset_ary)
  end
end

class Queen < Piece
  def initialize(board, color)
    super
    @symbol_pool = ["\u265B", "\u2655"]
    choose_symbol
  end

  def valid_moves
    offset_ary = [[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]
    
    return linear_movement(offset_ary)
  end
end

class King < Piece
  def initialize(board, color)
    super
    @symbol_pool = ["\u265A", "\u2654"]
    choose_symbol
  end

  def valid_moves
    offset_ary = [[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]

    return single_movement(offset_ary)
  end
end

class GameRender
  
  def self.render_board(board)
    hline = "  +--+--+--+--+--+--+--+--+\n"
    render_string = hline + "   A  B  C  D  E  F  G  H\n"
    
    system("clear")

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
    @player_to_go = :white
    @turns = 1

    start
  end

  def start
    loop do
      GameRender.render_board(@board)
      take_turn
    end
  end

  def take_turn
    loop do
      GameRender.render_board(@board)
      break if move_piece(@player_to_go)
    end
    next_turn
  end

  def next_turn
    @turns += 1
    @player_to_go == :white ? @player_to_go = :black : @player_to_go = :white
    @board.reset_enpassant(@player_to_go)
  end

  def move_piece(player)
    input = get_input
    from = []
    to = []

    from[0] = ("a".."h").to_a.index(input[0])
    from[1] = input[1].to_i - 1

    to[0] = ("a".."h").to_a.index(input[2])
    to[1] = input[3].to_i - 1

    subject = @board.layout[from]
    if subject && subject.color == player
      return true if @board.layout[from].move(to)
    end
    return false
  end

  def get_input
    input = ""
    loop do
      puts "#{@player_to_go} give me input"
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