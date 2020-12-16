
(** [Shape.t] is a representation of a single Tetris shape. A shape has a 
    name, anchor, orientation, and tiles that make up that shape.
    The [name] can be one of the following chars: I, J, L, T, Z, S, O
    The [orientation] is one of 0, 90, 180, 270 *)
type t 

(** [anchor] is the coordinates of the tile around which the shape rotates. *)
type anchor = (int * int)

(** [colorblind] is an int ref that changes depending on user input of whether
    or not the player is colorblind. Enables color settings. *)
val colorblind : int ref

(** [BadName] is raised if a shape is created with an invalid name. *)
exception BadName of char

(** [BadShape] is raised if a shape is malformed. *)
exception BadShape of t

(** [BadDirection] is raised if the rotation direction is invalid 
    (not 'L' or 'R'). *)
exception BadDirection of string

(** [BadColorPalette] is raised if there is an invalid int for the color 
    palette. *)
exception BadColorPalette of int

(** [DoneFalling] is raised when a shape runs into another shape or the
    bottom boundary of the board, preventing it from falling any further. *)
exception DoneFalling

(** [make_shape name anchor orientation cb] creates a Tetris shape of type 
    [name] with the anchor tile at location [anchor] and orientation 
    [orientation]. The color is determined by the type of the shape and 
    color-blindness setting [cb]. 
    Requires: [orientation] is a multiple of 90.
    Name options:
        'I'
        'J'
        'L'
        'T'
        'Z'
        'S'
        'O'
*)
val make_shape : char -> anchor -> int -> int -> t


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

(** [shape_shadow shape] is [shape] at the location where it would end up
    if it continued falling without moving left, right, or being rotated. *)
val shape_shadow : t -> t