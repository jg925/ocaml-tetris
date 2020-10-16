(** 
   Representation of tile data, including its location.
*)

(** ADT representing a tile*)
type t
(** Represents the location of the tile*)
type coord = (int * int)
(** Raised when a coordinate does not type correctly*)
exception BadCoord of coord

val get_x : t -> int

val get_y : t -> int
(** when called the tile will naturally 
    move one tile-length down the board, no user input required*)
val fall : t -> t
(** when called the tile will immediately 
    drop to the lowest available height on the board.*)
val drop : t -> unit