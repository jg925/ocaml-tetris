
(** [Tile.t] is a representation of a single tile on the game board with
    a color represented by three ints, red, green, and blue, and a location 
    represented by two ints, x and y. *)
type t

(** [make_tile x y r g b] takes in five ints representing the x and y 
    coordinates and red, green, and blue values of the tile and creates a 
    tile. *)
val make_tile : int -> int -> int -> int -> int -> t

(** [get_x tile] is the x-coordinate of [tile]. *)
val get_x : t -> int

(** [get_y tile] is the y-coordinate of [tile]. *)
val get_y : t -> int

(** [get_color tile] is the Graphics.color color corresponding to the 
    r, g, b values of [tile]. *)
val get_color : t -> Graphics.color

(** [tile_length] is the width and height of one tile, which defines the scale
    of the game board. *)
val tile_length : int


val set_y : t -> int -> t

(** [fall tile] is [tile] moved one tile-length down the board. *)
val fall : t -> t

(** [move_left tile] is [tile] moved one tile-length to the left. *)
val move_left : t -> t

(** [move_right tile] is [tile] moved one tile-length to the right. *)
val move_right : t -> t

(** [drop tile] is [tile] moved to the lowest available position on the 
    board directly below it. 
    NOTE: CURRENTLY UNIMPLEMENTED *)
val drop : t -> t