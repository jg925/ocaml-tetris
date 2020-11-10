(** [setup ()] creates a 10x20 Tetris game board upon which Tetris pieces can
    be drawn *)
val setup : unit -> unit

val x_dim : int

val y_dim : int

val top_offset : int

val left_offset : int

val tile_array : Tile.t option array array

(** [delete rows ()] removes any completed rows of 
    tiles from the gameboard and drops down tiles above it by a row 
    NOTE: CURRENTLY UNIMPLEMENTED*)
val delete_rows : unit -> unit

val display_tile : Tile.t -> unit

val display_shape : Shapes.t -> unit

val erase_tile : Tile.t -> unit

val erase_shape : Shapes.t -> unit

val display_score : int -> unit


(** [refresh ()] clears the game board and draws a new game board *)
val refresh : unit -> unit