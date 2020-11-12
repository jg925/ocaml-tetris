let x_dim = 10

let y_dim = 20

(** [tile_array] is a Tile.t option array that keeps track of which coordinates 
    of the board have a tile in them.*)
let tile_array = Array.make y_dim (Array.make x_dim None)

let set x y value = 
  let row = Array.get tile_array y in
  Array.set row x value

let get x y = 
  let row = Array.get tile_array y in 
  Array.get row x
