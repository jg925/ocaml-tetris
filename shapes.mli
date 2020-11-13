
(** [Shape.t] is a representation of a single Tetris shape. A shape has a 
    name, anchor, orientation, and tiles that make up that shape.
    The [name] can be one of the following chars: I, J, L, T, Z, S, O
    The [orientation] is one of 0, 90, 180, 270 *)
type t 

(** [anchor] is the coordinates of the tile around which the shape rotates. *)
type anchor = (int * int)

(** [make_shape] creates a Tetris shape of type [t] and *)
val make_shape : char -> anchor -> int -> t

exception BadName of char

(** [get_x shape] is the x coordinate of the anchor tile of [shape]. *)
val get_x : t -> int

(** [get_y shape] is the y coordinate of the anchor tile of [shape]. *)
val get_y : t -> int 

(** [get_tiles shape] is a list of the tiles that make up [shape]. *)
val get_tiles : t -> Tile.t list

(** [move_l shape] is [shape] moved one tile-length to the left. *)
val move_l : t -> t

(** [move_r shape] is [shape] moved one tile-length to the right. *)
val move_r : t -> t

(** [rotate_l shape] is [shape] rotated 90 degrees counter-clockwise. *)
val rotate_l : t -> t

(** [rotate_r shape] is [shape] rotated 90 degrees clockwise. *)
val rotate_r : t -> t

(** [fall shape] is [shape] moved one tile-length down the board. *)
val fall : t -> t

(** [drop shape] is [shape] moved to the lowest available position on the 
    board directly below it. 
    NOTE: CURRENTLY UNIMPLEMENTED *)
val drop : t -> t