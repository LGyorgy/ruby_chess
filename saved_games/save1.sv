--- &1 !ruby/object:Game
master: !ruby/object:Chess
  game: *1
board: &2 !ruby/object:Board
  dim: 8
  valid_coords:
  - - 0
    - 0
  - - 0
    - 1
  - - 0
    - 2
  - - 0
    - 3
  - - 0
    - 4
  - - 0
    - 5
  - - 0
    - 6
  - - 0
    - 7
  - - 1
    - 0
  - - 1
    - 1
  - - 1
    - 2
  - - 1
    - 3
  - - 1
    - 4
  - - 1
    - 5
  - - 1
    - 6
  - - 1
    - 7
  - - 2
    - 0
  - - 2
    - 1
  - - 2
    - 2
  - - 2
    - 3
  - - 2
    - 4
  - - 2
    - 5
  - - 2
    - 6
  - - 2
    - 7
  - - 3
    - 0
  - - 3
    - 1
  - - 3
    - 2
  - - 3
    - 3
  - - 3
    - 4
  - - 3
    - 5
  - - 3
    - 6
  - - 3
    - 7
  - - 4
    - 0
  - - 4
    - 1
  - - 4
    - 2
  - - 4
    - 3
  - - 4
    - 4
  - - 4
    - 5
  - - 4
    - 6
  - - 4
    - 7
  - - 5
    - 0
  - - 5
    - 1
  - - 5
    - 2
  - - 5
    - 3
  - - 5
    - 4
  - - 5
    - 5
  - - 5
    - 6
  - - 5
    - 7
  - - 6
    - 0
  - - 6
    - 1
  - - 6
    - 2
  - - 6
    - 3
  - - 6
    - 4
  - - 6
    - 5
  - - 6
    - 6
  - - 6
    - 7
  - - 7
    - 0
  - - 7
    - 1
  - - 7
    - 2
  - - 7
    - 3
  - - 7
    - 4
  - - 7
    - 5
  - - 7
    - 6
  - - 7
    - 7
  turn: 1
  layout:
    ? - 1
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *2
      first_move: true
    ? - 1
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *2
      first_move: true
    ? - 2
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *2
      first_move: true
    ? - 2
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *2
      first_move: true
    ? - 3
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *2
      first_move: true
    ? - 3
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *2
      first_move: true
    ? - 4
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *2
      first_move: true
    ? - 4
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *2
      first_move: true
    ? - 5
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *2
      first_move: true
    ? - 5
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *2
      first_move: true
    ? - 6
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *2
      first_move: true
    ? - 7
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *2
      first_move: true
    ? - 0
      - 0
    : !ruby/object:Rook
      symbol_pool:
      - "♜"
      - "♖"
      color: :white
      symbol: "♜"
      board: *2
      first_move: true
    ? - 7
      - 0
    : !ruby/object:Rook
      symbol_pool:
      - "♜"
      - "♖"
      color: :white
      symbol: "♜"
      board: *2
      first_move: true
    ? - 0
      - 7
    : !ruby/object:Rook
      symbol_pool:
      - "♜"
      - "♖"
      color: :black
      symbol: "♖"
      board: *2
      first_move: true
    ? - 2
      - 0
    : !ruby/object:Bishop
      symbol_pool:
      - "♝"
      - "♗"
      color: :white
      symbol: "♝"
      board: *2
      first_move: true
    ? - 2
      - 7
    : !ruby/object:Bishop
      symbol_pool:
      - "♝"
      - "♗"
      color: :black
      symbol: "♗"
      board: *2
      first_move: true
    ? - 5
      - 7
    : !ruby/object:Bishop
      symbol_pool:
      - "♝"
      - "♗"
      color: :black
      symbol: "♗"
      board: *2
      first_move: true
    ? - 1
      - 0
    : !ruby/object:Knight
      symbol_pool:
      - "♞"
      - "♘"
      color: :white
      symbol: "♞"
      board: *2
      first_move: true
    ? - 1
      - 7
    : !ruby/object:Knight
      symbol_pool:
      - "♞"
      - "♘"
      color: :black
      symbol: "♘"
      board: *2
      first_move: true
    ? - 4
      - 0
    : !ruby/object:King
      symbol_pool:
      - "♚"
      - "♔"
      color: :white
      symbol: "♚"
      board: *2
      first_move: true
    ? - 4
      - 7
    : !ruby/object:King
      symbol_pool:
      - "♚"
      - "♔"
      color: :black
      symbol: "♔"
      board: *2
      first_move: true
    ? - 3
      - 0
    : !ruby/object:Queen
      symbol_pool:
      - "♛"
      - "♕"
      color: :white
      symbol: "♛"
      board: *2
      first_move: true
    ? - 3
      - 7
    : !ruby/object:Queen
      symbol_pool:
      - "♛"
      - "♕"
      color: :black
      symbol: "♕"
      board: *2
      first_move: true
    ? - 0
      - 4
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *2
      first_move: false
    ? - 0
      - 2
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *2
      first_move: false
    ? - 5
      - 5
    : !ruby/object:Knight
      symbol_pool:
      - "♞"
      - "♘"
      color: :black
      symbol: "♘"
      board: *2
      first_move: false
    ? - 7
      - 2
    : !ruby/object:Knight
      symbol_pool:
      - "♞"
      - "♘"
      color: :white
      symbol: "♞"
      board: *2
      first_move: false
  enpassant_target:
    :white: []
    :black: []
  captured_pieces:
    :white:
    - !ruby/object:Knight
      symbol_pool:
      - "♞"
      - "♘"
      color: :white
      symbol: "♞"
      board: *2
      first_move: true
    - !ruby/object:Bishop
      symbol_pool:
      - "♝"
      - "♗"
      color: :white
      symbol: "♝"
      board: *2
      first_move: false
    :black:
    - !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *2
      first_move: false
    - !ruby/object:Rook
      symbol_pool:
      - "♜"
      - "♖"
      color: :black
      symbol: "♖"
      board: *2
      first_move: false
ghost_board: &3 !ruby/object:Board
  dim: 8
  valid_coords:
  - - 0
    - 0
  - - 0
    - 1
  - - 0
    - 2
  - - 0
    - 3
  - - 0
    - 4
  - - 0
    - 5
  - - 0
    - 6
  - - 0
    - 7
  - - 1
    - 0
  - - 1
    - 1
  - - 1
    - 2
  - - 1
    - 3
  - - 1
    - 4
  - - 1
    - 5
  - - 1
    - 6
  - - 1
    - 7
  - - 2
    - 0
  - - 2
    - 1
  - - 2
    - 2
  - - 2
    - 3
  - - 2
    - 4
  - - 2
    - 5
  - - 2
    - 6
  - - 2
    - 7
  - - 3
    - 0
  - - 3
    - 1
  - - 3
    - 2
  - - 3
    - 3
  - - 3
    - 4
  - - 3
    - 5
  - - 3
    - 6
  - - 3
    - 7
  - - 4
    - 0
  - - 4
    - 1
  - - 4
    - 2
  - - 4
    - 3
  - - 4
    - 4
  - - 4
    - 5
  - - 4
    - 6
  - - 4
    - 7
  - - 5
    - 0
  - - 5
    - 1
  - - 5
    - 2
  - - 5
    - 3
  - - 5
    - 4
  - - 5
    - 5
  - - 5
    - 6
  - - 5
    - 7
  - - 6
    - 0
  - - 6
    - 1
  - - 6
    - 2
  - - 6
    - 3
  - - 6
    - 4
  - - 6
    - 5
  - - 6
    - 6
  - - 6
    - 7
  - - 7
    - 0
  - - 7
    - 1
  - - 7
    - 2
  - - 7
    - 3
  - - 7
    - 4
  - - 7
    - 5
  - - 7
    - 6
  - - 7
    - 7
  turn: 1
  layout:
    ? - 0
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *3
      first_move: true
    ? - 0
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *3
      first_move: true
    ? - 1
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *3
      first_move: true
    ? - 1
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *3
      first_move: true
    ? - 2
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *3
      first_move: true
    ? - 2
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *3
      first_move: true
    ? - 3
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *3
      first_move: true
    ? - 3
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *3
      first_move: true
    ? - 4
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *3
      first_move: true
    ? - 4
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *3
      first_move: true
    ? - 5
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *3
      first_move: true
    ? - 5
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *3
      first_move: true
    ? - 6
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *3
      first_move: true
    ? - 6
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *3
      first_move: true
    ? - 7
      - 1
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :white
      symbol: "♟"
      board: *3
      first_move: true
    ? - 7
      - 6
    : !ruby/object:Pawn
      symbol_pool:
      - "♟"
      - "♙"
      color: :black
      symbol: "♙"
      board: *3
      first_move: true
    ? - 0
      - 0
    : !ruby/object:Rook
      symbol_pool:
      - "♜"
      - "♖"
      color: :white
      symbol: "♜"
      board: *3
      first_move: true
    ? - 7
      - 0
    : !ruby/object:Rook
      symbol_pool:
      - "♜"
      - "♖"
      color: :white
      symbol: "♜"
      board: *3
      first_move: true
    ? - 0
      - 7
    : !ruby/object:Rook
      symbol_pool:
      - "♜"
      - "♖"
      color: :black
      symbol: "♖"
      board: *3
      first_move: true
    ? - 7
      - 7
    : !ruby/object:Rook
      symbol_pool:
      - "♜"
      - "♖"
      color: :black
      symbol: "♖"
      board: *3
      first_move: true
    ? - 2
      - 0
    : !ruby/object:Bishop
      symbol_pool:
      - "♝"
      - "♗"
      color: :white
      symbol: "♝"
      board: *3
      first_move: true
    ? - 5
      - 0
    : !ruby/object:Bishop
      symbol_pool:
      - "♝"
      - "♗"
      color: :white
      symbol: "♝"
      board: *3
      first_move: true
    ? - 2
      - 7
    : !ruby/object:Bishop
      symbol_pool:
      - "♝"
      - "♗"
      color: :black
      symbol: "♗"
      board: *3
      first_move: true
    ? - 5
      - 7
    : !ruby/object:Bishop
      symbol_pool:
      - "♝"
      - "♗"
      color: :black
      symbol: "♗"
      board: *3
      first_move: true
    ? - 1
      - 0
    : !ruby/object:Knight
      symbol_pool:
      - "♞"
      - "♘"
      color: :white
      symbol: "♞"
      board: *3
      first_move: true
    ? - 6
      - 0
    : !ruby/object:Knight
      symbol_pool:
      - "♞"
      - "♘"
      color: :white
      symbol: "♞"
      board: *3
      first_move: true
    ? - 1
      - 7
    : !ruby/object:Knight
      symbol_pool:
      - "♞"
      - "♘"
      color: :black
      symbol: "♘"
      board: *3
      first_move: true
    ? - 6
      - 7
    : !ruby/object:Knight
      symbol_pool:
      - "♞"
      - "♘"
      color: :black
      symbol: "♘"
      board: *3
      first_move: true
    ? - 4
      - 0
    : !ruby/object:King
      symbol_pool:
      - "♚"
      - "♔"
      color: :white
      symbol: "♚"
      board: *3
      first_move: true
    ? - 4
      - 7
    : !ruby/object:King
      symbol_pool:
      - "♚"
      - "♔"
      color: :black
      symbol: "♔"
      board: *3
      first_move: true
    ? - 3
      - 0
    : !ruby/object:Queen
      symbol_pool:
      - "♛"
      - "♕"
      color: :white
      symbol: "♛"
      board: *3
      first_move: true
    ? - 3
      - 7
    : !ruby/object:Queen
      symbol_pool:
      - "♛"
      - "♕"
      color: :black
      symbol: "♕"
      board: *3
      first_move: true
  enpassant_target: {}
  captured_pieces:
    :white: []
    :black: []
player_to_go: :black
turns: 8
resumed: false
