
exception End

(** [x_dim] is the number of columns on the Tetris board. *)
val x_dim : int

(** [y_dim] is the number of rows on the Tetris board.*)
val y_dim : int


val tile_array : Tile.t option array


val score : int ref


val level : int ref

(** [set x y value] sets the value in tile_array at row [y] column [x] to 
    [value]. 
    Requires: [value] to be a Tile.t option or None. *)
val set : int -> int -> Tile.t option -> unit

val delete_rows : int list -> unit

(** [get x y] gives the value at the corresponding tile at ([x],[y]) in the 
    array. 
    Requires: [x] and [y] to be within the bounds of the board. *)
val get : int -> int -> Tile.t option
