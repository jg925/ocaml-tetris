(* [coord] is an (x,y) tuple representing the lower left corner of the tile *)
type coord = (int * int)

(* [color] is an (r,g,b) tuple representing the red, green, and blue values 
   of the tile color *)
type color = (int * int * int)

type t = {
  location : coord;
  color : color
}

exception BadTile of t

let make_coord x y = (x, y)

let make_color r g b = (r, g, b)

let create_tile x y r g b = 
  {
    location = make_coord x y;
    color = make_color r g b
  }

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

let fall tile scale = move_to tile (get_x tile) (get_y tile - scale)

let move_left tile scale = move_to tile (get_x tile - scale) (get_y tile)

let move_right tile scale = move_to tile (get_x tile + scale) (get_y tile)

let drop tile = failwith "unimplemented"

