(** abstraction for shapes, an amalgamation of 4 adjacent tiles.*)

open Tile
(** ADT representing the shape*)
type t
(** every shape has its own "anchor tile"
    which dictates how the shape will rotate.*)
type anchor_tile = Tile.t
(**Returns the anchor tile of the shape. *)
val get_anc_tile : t -> anchor_tile

(* val get_x : t -> int 

val get_y : t -> int *)

val move_l : t -> t -> unit

val move_r : t -> t -> unit

val rotate_l : t -> t -> unit

val rotate_r : t -> t -> unit

val drop : t -> t -> unit

