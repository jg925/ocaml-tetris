(** abstraction for shapes, an amalgamation of 4 adjacent tiles.*)

open Tile

(** ADT representing the shape*)
type t 

(** every shape has its own "anchor tile"
    which dictates how the shape will rotate.*)
type anchor_tile = Tile.t

(**Returns the anchor tile of the shape. *)
val get_anchor_tile : t -> anchor_tile

val get_x : t -> int

val get_y : t -> int 

(** Moves the entire shape one tile-length to the left*)
val move_l : t -> t

(** Moves the entire shape one tile-length to the right*)
val move_r : t -> t

(** Rotates the entire shape 90 degrees counter-clockwise*)
val rotate_l : t -> t

(** Rotates the entire shape 90 degrees clockwise*)
val rotate_r : t -> t

(** Moves the entire shape one tile-length downward*)
val fall : t -> t

(** Moves the entire shape to the lowest
    available point on the board without clipping.*)
val drop : t -> t