(** 
   Representation of tile data, including its location.
*)
type coord
type color

(** ADT representing a tile*)
type t

(** Raised when a tile does not type correctly*)
exception BadTile of t

val create_tile : int -> int -> int -> int -> int -> t

val get_x : t -> int

val get_y : t -> int

val get_color : t -> Graphics.color

val move_to : t -> int -> int -> t

(** when called the tile will naturally 
    move one tile-length down the board, no user input required*)
val fall : t -> int -> t

val move_left : t -> int -> t

val move_right : t -> int -> t

(** when called the tile will immediately 
    drop to the lowest available height on the board.*)
val drop : t -> int -> t