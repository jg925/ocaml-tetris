(** [setup ()] creates a Tetris game board upon which Tetris pieces can
    be drawn *)
val setup : unit -> unit

(** [delete rows ()] removes any completed rows of 
    tiles from the gameboard and drops down tiles above it by a row 
    NOTE: CURRENTLY UNIMPLEMENTED *)
val delete_rows : unit -> unit

(** [display_tile tile] draws [tile] on the game board. *)
val display_tile : Tile.t -> unit

(** [display_shape shape] draws [shape] on the game board. *)
val display_shape : Shapes.t -> unit

(** [erase_tile tile] erases [tile] from the game board. *)
val erase_tile : Tile.t -> unit


val erase_coords : int -> int -> unit

(** [erase_shape shape] erases [shape] from the game board. *)
val erase_shape : Shapes.t -> unit

(** [display_score score] draws the score [score] on the game board. *)
val display_score : int -> unit

(** [refresh ()] clears the game board and draws a new game board. *)
val refresh : unit -> unit