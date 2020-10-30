
(** [Tile.t] is a representation of a single tile on the game board with
    a color represented by three ints, red, green, and blue, and a location 
    represented by two ints, x and y*)
type t

(** [create_tile x y r g b] takes in five ints representing the x and y 
    coordinates and red, green, and blue values of the tile and creates a 
    tile *)
val create_tile : int -> int -> int -> int -> int -> t

(** [get_x tile] is the x-coordinate of [tile] *)
val get_x : t -> int

(** [get_y tile] is the y-coordinate of [tile] *)
val get_y : t -> int

(** [get_color tile] is the Graphics.color color corresponding to the 
    r, g, b values of [tile] *)
val get_color : t -> Graphics.color

val tile_length: int

(** [move_to tile x y] creates a tile with the same attributes as [tile] 
    except the x and y coordinates are changed to [x] and [y] 
    NOTE: in the future I think we might want to change this function to 
    be a hidden helper function not exposed in the mli*)
val move_to : t -> int -> int -> t

(** [fall tile] moves the tile down the game board by 1 *)
val fall : t -> t

(** [move_left tile] moves the tile to the left on the game board by 1 *)
val move_left : t -> t

(** [move_right tile] moves the tile to the right on the game board by 1 *)
val move_right : t -> t

(** [drop tile] drops the tile to the lowest available position on the 
    game board
    NOTE: CURRENTLY UNIMPLEMENTED *)
val drop : t -> t