(** [key_array] stores the keys that will be used to move the shape Left, 
    Right, Rotate CCW, Rotate CW, and Fall Faster in that order. *)
val key_array : char array ref

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

(** [setup_board ()] creates a Tetris game board including grid lines upon 
    which Tetris pieces can be drawn. *)
val setup_board : unit -> unit

(** [refresh ()] clears the game board and draws a new game board. *)
val refresh : unit -> unit



(** [display_welcome_screen ()] displays a welcome message for the user 
    prompting them to press any key to begin. *)
val display_welcome_screen : unit -> unit

(** [display_game_over_screen ()] displays a game over message to the user
    prompting them to press 'r' to play another round or 'q' to quit the 
    game. It also informs the user what score they received that round and 
    whether it was a new high score. *)
val display_game_over_screen : int -> int -> unit

(** [display_controls ()] displays the keys the user needs to press to move
    the shape Left, Right Rotate CCW, Rotate CW, Fall Faster, Drop, and 
    pause the game. *)
val display_controls : unit -> unit

(** [display_score score] displays the score [score] on the game board. *)
val display_score : int -> unit

(** [display_high_scores high_score] displays the high score board 
    [high_scores] on the board. *)
val display_high_scores : int list -> unit



(** [display_tile tile bevel color] draws a tile on the game board at the 
    location contained in [tile] using the color [color]. If [bevel] is
    true the tile is drawn with beveled edges, otherwise it is drawn as
    one solid color. *)
val display_tile : Tile.t -> bool -> Graphics.color -> unit

(** [erase_tile tile] erases [tile] from the game board by drawing a white 
    tile at the location contained in [tile]. *)
val erase_tile : Tile.t -> unit

(** [erase_coords x y] draws a white tile at the location specified by [x]
    and [y]. *)
val erase_coords : int -> int -> unit



(** [display_shape shape] draws [shape] on the game board at the locations 
    specified by the tiles in [shape]. *)
val display_shape : Shapes.t -> unit

(** [display_shadow shape] draws [shape] on the game board at the locations 
    specified by the tiles in [shape] with a light gray color. *)
val display_shadow : Shapes.t -> unit

(** [erase_shape shape] erases [shape] from the game board by drawing white 
    squares at the location of each of the tiles contained in [shape]. *)
val erase_shape : Shapes.t -> unit



(** [display_next_shape_words ()] displays words above where the next shape 
    the user will have is drawn. *)
val display_next_shape_words : unit -> unit

(** [display_next_shape shape] displays [shape] off to the side of the game 
    board. This function is intended to be used for showing the user what
    shape they will have to play next. *)
val display_next_shape : Shapes.t -> unit

(** [erase_last_next_shape shape] erases the [shape] displayed to the side
    of the board by drawing white squares at the location of each of it's 
    tiles *)
val erase_last_next_shape : Shapes.t -> unit

