
(** [End] is raised when [tile_array] has reached the top of the board and 
    shapes can no longer be generated and fall. *)
exception End

(** [x_dim] is the number of columns on the Tetris board. *)
val x_dim : int

(** [y_dim] is the number of rows on the Tetris board. *)
val y_dim : int

(** [tile_array] is a Tile.t option array representing the tiles that have
    finished falling. Each entry in the array is [None] if there is no tile
    stored at that location, or [Some tile] if [tile] is stored there. *)
val tile_array : Tile.t option array

(** [score] is a ref containing the score the player has acheieved so far in
    the current round. *)
val score : int ref

(** [high_scores] is initialized to all zeros. As rounds are played, if the 
    score acheived is higher than one of the high scores, the score replaces 
    that score in the high score array.
    RI: [high_score] must always contain the scores ordered from highest to 
    lowest. *)
val high_scores : int array

(** [update_high_score score] updates [high_scores] with [score]. *)
val update_high_score : int -> unit

(** [set x y value] sets the value in tile_array at row [y] column [x] to 
    [value].
    Requires: [x] and [y] to be within the bounds of the board.*)
val set : int -> int -> Tile.t option -> unit

(** [get x y] gives the corresponding Tile.t option stored at row [y] and 
    column [x].
    Requires: [x] and [y] to be within the bounds of the board. *)
val get : int -> int -> Tile.t option

(** [delete_rows ys] checks if the rows corresponding to the y coordinates
    in [ys] are completed in [tile_array]. For any row that is completed, 
    every row above it is shifted down by a row, and a row of [None] is 
    added at the top. *)
val delete_rows : int list -> unit

(** [clear ()] clears [tile_array], restoring every entry to [None] to 
    indicate that there are no tiles stored in [tile_array]. *)
val clear : unit -> unit
