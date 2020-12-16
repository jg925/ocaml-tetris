
(** [set_settings ()] takes user input for game settings and sets the 
    corresponding refs to the chosen settings.
    Keybind settings:
    adwsxr
    jlik,r
    fhtgbr
    Color palette settings:
    Regular
    Deuteranopia
    Protanopia
    Tritanopia
    Monochromacy *)
val set_settings : unit -> unit

(** [display_welcome_screen ()] displays a welcome message for the user 
    prompting them to press any key to begin. *)
val display_welcome_screen : unit -> unit

(** [display_game_over_screen ()] displays a game over message to the user
    prompting them to press 'r' to play another round or 'q' to quit the 
    game. It also informs the user what score they received that round and 
    whether it was a new high score. *)
val display_game_over_screen : int -> int -> unit

(** [setup_board ()] creates a Tetris game board including grid lines upon 
    which Tetris pieces can be drawn. *)
val setup_board : unit -> unit


val key_array : char array ref

val display_controls : unit -> unit

val left : unit -> int

val right : unit -> int

val upper : unit -> int
(** 

   NOTE: need to update this spec

   [display_tile tile] draws [tile] on the game board. *)
val display_tile : Tile.t -> bool -> Graphics.color -> unit


val display_next_shape : Shapes.t -> unit


(** [display_shape shape] draws [shape] on the game board. *)
val display_shape : Shapes.t -> unit

val display_shadow : Shapes.t -> unit

(** [erase_tile tile] erases [tile] from the game board. *)
val erase_tile : Tile.t -> unit


val erase_coords : int -> int -> unit


val erase_last_next_shape : Shapes.t -> unit

(** [erase_shape shape] erases [shape] from the game board. *)
val erase_shape : Shapes.t -> unit

(** [display_score score] draws the score [score] on the game board. *)
val display_score : int -> unit


val display_high_scores : int list -> unit

val display_next_shape_words : unit -> unit

(** [refresh ()] clears the game board and draws a new game board. *)
val refresh : unit -> unit