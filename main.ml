let test_tile = Tile.make_tile 1 2 100 0 0
let test_shape = Shapes.make_shape 'J' (100, 100) 0

let start () = 
  let score = 0 in
  Board.setup ();
  let rec game_loop ()=
    Board.display_tile test_tile;
    Board.display_score score; 
    Board.refresh () in
  failwith "unimplemented"

let pause () = ()