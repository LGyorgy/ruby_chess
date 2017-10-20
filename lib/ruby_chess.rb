require "yaml"
class Board
  attr_reader :layout, :valid_coords, :turn
  attr_accessor :enpassant_target, :captured_pieces

  def initialize
    @dim = 8
    @valid_coords = []

    8.times do |i|
      8.times do |j|
        @valid_coords << [i,j]
      end
    end

    @turn = 1
    @layout = {}
    @enpassant_target = {}
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

  def get_pieces_by_color(color)
    pieces_ary = []
    @layout.each_value do |piece|
      pieces_ary << piece if piece.color == color
    end

    return pieces_ary
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

  def under_attack_by(color)
    under_attack_ary = []
    @layout.each_value do |piece|
      if piece.color == color
        under_attack_ary += piece.can_attack
      end
    end
    return under_attack_ary.uniq
  end

  def check_by?(color)
    possible_checks = under_attack_by(color)
    possible_checks.each do |square|
      piece = @layout[square]
      if piece && piece.is_a?(King) && piece.color != color
        return true
      end
    end
    return false
  end

  def under_attack_alg_by(color)
    can_attack_ary = under_attack_by(color)
    string_ary = []

    can_attack_ary.each do |coords|
      coords_string = ""
      letter = ("A".."H").to_a[coords[0]]
      coords_string = letter + (coords[1]+1).to_s
      string_ary << coords_string
    end
    return string_ary.sort
  end

  def square_empty?(coords)
    return true unless @layout[coords]
    return false
  end

  def at_coords(coords)
    return @layout[coords]
  end

  def make_a_move(player, from, to)
    subject = at_coords(from)
    if subject && subject.color == player
      if !BoardAnalyzer.move_into_check?(self, player, from, to)
        return subject.move(to)
      end
    end
    return false
  end
end

class Piece
  attr_reader :symbol, :color, :first_move

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

  def can_attack
    return valid_moves
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

  def black_modifier
    if @color == :black
      return -1
    else
      return 1
    end
  end

  def valid_moves
    cur_pos = pos
    valid_pos =[]

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

  def can_attack
    cur_pos = pos
    can_attack_ary = []
    pos_to_check = [cur_pos[0]+1, cur_pos[1]+(1*black_modifier)]
      can_attack_ary << pos_to_check if @board.valid_coords.include?(pos_to_check)
    pos_to_check = [cur_pos[0]-1, cur_pos[1]+(1*black_modifier)]
      can_attack_ary << pos_to_check if @board.valid_coords.include?(pos_to_check)
    return can_attack_ary
  end
end

class Rook < Piece
  def initialize(board, color)
    super
    @symbol_pool = ["\u265C", "\u2656"]
    choose_symbol
  end

  def valid_moves
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
    valid_moves_ary = []
    offset_ary = [[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]

    valid_moves_ary += single_movement(offset_ary)
    if @first_move
      valid_moves_ary << [2,rank] if queenside_castle?
      valid_moves_ary << [6,rank] if kingside_castle?
    end
    return valid_moves_ary
  end

  def move(to)
    if valid_moves.include?(to)
      castling(to) if @first_move
      if check_collision(to) == -1
        capture(to)
      end
      move_piece(to)
      @first_move = false
      return true
    end
    return false
  end

  def castling(to)
    return false if !valid_moves.include?(to)
    if to == [2,rank]
      @board.layout[[0,rank]].move([3,rank])
      return true
    elsif to == [6,rank]
      @board.layout[[7,rank]].move([5,rank])
      return true
    else
      return false
    end   
  end

  def can_attack
    valid_moves_ary = []
    offset_ary = [[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,1],[-1,-1],[1,-1]]

    valid_moves_ary += single_movement(offset_ary)
    return valid_moves_ary
  end

  def rank
    return 7 if @color == :black
    return 0
  end

  def kingside_castle?
    under_attack_ary = @board.under_attack_by(enemy)
    has_to_be_safe = [[4,rank],[5,rank],[6,rank]]
    rook_coords = [7, rank]

    kings_first_move = @first_move = true
    rooks_first_move = !@board.square_empty?(rook_coords) && @board.layout[rook_coords].first_move == true
    path_empty = @board.square_empty?([6,rank]) && @board.square_empty?([5,rank])
    safe = (has_to_be_safe - under_attack_ary == has_to_be_safe)
    return kings_first_move && rooks_first_move && path_empty && safe
  end

  def queenside_castle?

    under_attack_ary = @board.under_attack_by(enemy)
    has_to_be_safe = [[4,rank],[3,rank],[2,rank]]
    rook_coords = [0, rank]
    
    kings_first_move = @first_move = true
    rooks_first_move = !@board.square_empty?(rook_coords) && @board.layout[rook_coords].first_move == true
    path_empty = @board.square_empty?([3,rank]) && @board.square_empty?([2,rank]) && @board.square_empty?([1,rank])
    safe = (has_to_be_safe - under_attack_ary == has_to_be_safe)
    return kings_first_move && rooks_first_move && path_empty && safe
  end
end

class GameRender
  
  def self.render_board(board, message = "")
    hline = "  +--+--+--+--+--+--+--+--+\n"
    render_string = hline + "   A  B  C  D  E  F  G  H\n"
    
    system("clear")

    8.times do |y|
      row_string = "#{y+1} |"

      8.times do |x|
        cell = board.at_coords([x,y])

        row_string << (cell != nil ? "#{cell.symbol} |" : "  |")
      end

      row_string << " #{y+1}"
      render_string = hline + (row_string + "\n") + render_string
    end

    render_string = "   A  B  C  D  E  F  G  H\n" + render_string
    print render_string
    puts message
  end

end

class BoardAnalyzer
  def self.move_into_check?(board, player, from, to)
    ghost_board = Marshal.load(Marshal.dump(board))
    ghost_board.at_coords(from).move(to)
    return ghost_board.check_by?(enemy(player))
  end

  def self.check_by?(board,player)
    board.check_by?(enemy(player))
  end

  def self.enemy(player)
    player == :white ? :black : :white
  end

  def self.checkmate_by?(board, player)
    board.get_pieces_by_color(enemy(player)).each do |piece|
      piece.valid_moves.each do |move|
        if !move_into_check?(board, enemy(player), piece.pos, move)
          return false
        end
      end
    end
    return true
  end
end

class Game
  def initialize(master)
    @master = master
    @board = Board.new
    @ghost_board = Board.new
    @player_to_go = :white
    @turns = 1
    @resumed
  end

  def start
    loop do
      break if take_turn
    end
  end
  
  def resume
    @resumed = true
    start
  end

  def render_turn(msg)
    message = message_of_this_turn + "\n" + msg
    GameRender.render_board(@board, message)
  end

  def take_turn
    if @resumed
      render_turn ("Game loaded! Make a move!")
      @resumed = false
    else
      render_turn("Make a move!")
    end
    loop do
      break if move_piece
      render_turn("Illegal move! Try again!")
    end
    if BoardAnalyzer.checkmate_by?(@board, @player_to_go)
      message = "Checkmate! #{@player_to_go.to_s.capitalize} wins!"
      GameRender.render_board(@board, message)
      return true
    end
    next_turn
    return false
  end

  def next_turn
    @turns += 1 if @player_to_go == :black
    @player_to_go == :white ? @player_to_go = :black : @player_to_go = :white
    @board.reset_enpassant(@player_to_go)
  end

  def enemy
    @player_to_go == :white ? :black : :white
  end

  def move_piece
    loop do
      input = get_input
      coords = input_to_coords(input)
      from = coords[0]
      to = coords[1]
      
      return true if @board.make_a_move(@player_to_go, from, to)

      msg = "Illegal move!"
      subject = @board.at_coords(from)
      if !subject
        msg += " No piece there!"
      elsif subject && subject.color == enemy
        msg += " It is not your piece!"
      elsif BoardAnalyzer.move_into_check?(@board, @player_to_go, from, to)
        if BoardAnalyzer.check_by?(@board, enemy)
          msg += " You must move out of check!"
        else
          msg += " You would move into check!"
        end
      end
      msg += " Try again!"
      render_turn(msg)
    end
  end

  def message_of_this_turn
    message = "#{@turns}. turn: "
    message += "Check! " if BoardAnalyzer.check_by?(@board, @player_to_go)
    message += "#{@player_to_go.to_s.capitalize} to go!"
    message
  end

  def save(file_name)
    Dir.mkdir("saved_games") unless File.exists?("saved_games")
    File.open("saved_games/#{file_name}.sv", "w+") do |file|
      file.puts YAML::dump(self)
    end
  end

  def load(file_name)
    @master.load(file_name)
  end

  def get_input
    input = ""
    loop do
      input = gets.chomp.downcase
      if input == "save"
        save("save1")
        render_turn("Game Saved! Make your move!")
        next
      end
      if input == "load"
        load("save1")
        render_turn("Game Loaded! Make your move!")
        next
      end
      if input == "exit"
        render_turn("Exiting game... Good bye!")
        exit
      end
      break if valid_input?(input)
      render_turn("Invalid command! Try again!")
    end
    return input
  end

  def valid_input?(input)
    return false if input.length != 4
    return false unless ('a'..'h').include?(input[0]) && ('a'..'h').include?(input[2])
    return false unless (1..8).include?(input[1].to_i) && (1..8).include?(input[1].to_i)
    return true
  end

  def input_to_coords(input)
    from = []
    to = []

    from[0] = ("a".."h").to_a.index(input[0])
    from[1] = input[1].to_i - 1

    to[0] = ("a".."h").to_a.index(input[2])
    to[1] = input[3].to_i - 1
    return [from,to]
  end
end

class Chess
  def initialize
    @game = Game.new(self)
    start
  end

  def start
    @game.start
  end

  def load(file_name)
    return false unless File.exists?("saved_games/#{file_name}.sv")
    save_file = File.open("saved_games/#{file_name}.sv", "r")
    @game = YAML::load(save_file)
    @game.resume
    return true
  end
end

Chess.new