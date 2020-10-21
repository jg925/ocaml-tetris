(* insert tile code here*)

type coord = (int * int)

(* a tile should be an x, y representing lower left corner and a color*)
type t = {
  location : coord;
  color : string
}
exception BadTile of t

let set_tile_length = 50

let get_x tile = 
  match tile.location with 
  | (x,_) -> x

let get_y tile = 
  match tile.location with 
  | (_,y) -> y

let move_to tile x y = {tile with location = (x, y)}

(* TODO: right now I wrote -1 but the actual size of a tile is 50 pixels.
   We'll probably want to abstract this out in some way so we can change the 
   size of tiles, I just wasn't sure how to do that rn. *)
let fall tile = move_to tile (get_x tile) (get_y tile - (1*set_tile_length))

let move_left tile = move_to tile (get_x tile - (1*set_tile_length)) (get_y tile)

let move_right tile = move_to tile (get_x tile + (1*set_tile_length)) (get_y tile)

let drop tile = failwith "unimplemented"