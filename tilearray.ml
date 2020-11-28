let x_dim = 10

let y_dim = 24

(** [tile_array] is a Tile.t option array that keeps track of which coordinates 
    of the board have a tile in them.*)
let tile_array = Array.make (y_dim * x_dim) None

let array_index x y = y * x_dim + x

let set x y value = 
  let index = array_index x y in
  tile_array.(index) <- value


let get x y = 
  let index = array_index x y in
  tile_array.(index)

