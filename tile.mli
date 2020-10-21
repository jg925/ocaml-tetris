(** 
   Representation of tile data, including its location.
*)

(** ADT representing a tile*)
type t

(** Raised when a tile does not type correctly*)
exception BadTile of t

val set_tile_length : int

val get_x : t -> int

val get_y : t -> int

val get_length : t -> int
(** when called the tile will naturally 
    move one tile-length down the board, no user input required*)
val fall : t -> t

(** when called the tile will immediately 
    drop to the lowest available height on the board.*)
val drop : t -> unit