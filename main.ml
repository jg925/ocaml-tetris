let score = 0

let test_tile = Tile.create_tile 1 2 100 0 0

let display_score () = 
  Graphics.moveto 0 0;
  Graphics.draw_string ("Score: " ^ string_of_int score); ()

let start () = 
  Board.setup (); 
  Board.display_tile test_tile;
  display_score (); ()

let pause () = ()