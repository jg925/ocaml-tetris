let test_tile = Tile.create_tile 1 2 100 0 0
let start () = 
  let score = 0 in
  Board.setup ();
  let rec game_loop ()=
    Board.display_tile test_tile;
    Board.display_score score; 
    Board.refresh () in
  failwith "unimplemented"

let pause () = ()