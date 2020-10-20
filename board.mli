(*insert board abstraction here*)
type t

val setup : unit

val delete_rows : t -> t

(** refreshes the board, and gets it ready for the next frame.*)
val refresh : unit