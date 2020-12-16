
(** [Tile.t] is a representation of a single tile with a color and 
    a location. *)
type t

(** [tile_length] is the width and height of one tile, which defines the scale
    of the game board. *)
val tile_length : int

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

(** [set_x tile x] is the same tile as [tile] but with the x coordinate
    changed to [x]. *)
val set_x : t -> int -> t

(** [set_y tile y] is the same tile as [tile] but with the y coordinate
    changed to [y]. *)
val set_y : t -> int -> t

(** [move_to tile x y] is the same tile as [tile] but with the x and y 
    coordinates of the location changed to [x] and [y]. *)
val move_to : t -> int -> int -> t

(** [fall tile] is [tile] moved one tile-length down the board. *)
val fall : t -> t

(** [move_left tile] is [tile] moved one tile-length to the left. *)
val move_left : t -> t

(** [move_right tile] is [tile] moved one tile-length to the right. *)
val move_right : t -> t

