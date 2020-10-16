(*insert board abstraction here*)
type t

val setup : t -> unit

val delete_row: t -> t
(** refreshes the board, and gets it ready for the next frame.*)
val refresh : t->unit