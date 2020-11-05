let score = 0

let test_tile = Tile.create_tile 1 2 100 0 0

let start () = Board.setup (); Board.display_tile test_tile

let display_score () = 
  Graphics.draw_string ("Score: " ^ string_of_int score); ()

let pause () = ()