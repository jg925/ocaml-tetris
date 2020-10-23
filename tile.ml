(* insert tile code here*)

type coord = (int * int)

(* a tile should be an x, y representing lower left corner and a color*)
type t = {
  location : coord;
  color : (int * int * int)
}
exception BadTile of t

let get_x tile = 
  match tile.location with 
  | (x,_) -> x

let get_y tile = 
  match tile.location with 
  | (_,y) -> y

let get_color tile = 
  match tile.color with 
  | (r,g,b) -> Graphics.rgb r g b

let move_to tile x y = {tile with location = (x, y)}

let fall tile size = move_to tile (get_x tile) (get_y tile - size)

let move_left tile size = move_to tile (get_x tile - size) (get_y tile)

let move_right tile size = move_to tile (get_x tile + size) (get_y tile)

let drop tile size = failwith "unimplemented"

