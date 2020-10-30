(** [setup ()] creates a 10x20 Tetris game board upon which Tetris pieces can
    be drawn *)
val setup : unit -> unit

(** [delete rows ()] removes any completed rows of 
    tiles from the gameboard and drops down tiles above it by a row 
    NOTE: CURRENTLY UNIMPLEMENTED*)
val delete_rows : unit -> unit


val display_tile: Tile.t -> unit

val display_shape: Shapes.t -> unit
(** [refresh ()] clears the game board and draws a new game board *)
val refresh : unit -> unit