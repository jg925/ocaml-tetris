(*insert board code here*)
open Tile
(**The board should be a mutable array of tiles,
   in which any rows of the board that are empty 
   are removed from the array to save space.*)
type t = int

(** [setup] opens a Graphics window and draws the board outline for Tetris.
    The board is 10x20 blocks where each block is 50x50 pixels.*)
let increment = Tile.set_tile_length
let setup =  
  let lower = 70 in 
  let upper = lower + (20 * increment) in 
  let left = 100 in
  let right = left + (10 * increment) in
  Graphics.open_graph " 700x1000";
  Graphics.set_window_title "Tetris";
  Graphics.set_line_width 2;
  Graphics.moveto left lower;
  Graphics.lineto right lower;
  Graphics.lineto right upper;
  Graphics.lineto left upper;
  Graphics.lineto left lower


let delete_rows board = 
  failwith "unimplemented"

let refresh = failwith "unimplemented"
(*Graphics.close_graph (); setup*)