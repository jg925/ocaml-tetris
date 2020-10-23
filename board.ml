let scale = 50

(** [setup] opens a Graphics window and draws the board outline for Tetris.
    The board is 10x20 blocks where each block is a square with width and 
    height both equal to [scale] pixels.*)
let setup () =  
  let lower = 2 * scale in 
  let upper = lower + (20 * scale) in 
  let left = 2 * scale in
  let right = left + (10 * scale) in
  let width = right + 2 * scale in
  let height = upper + 2*scale in 
  " " ^ (string_of_int width) ^ "x" ^ (string_of_int height) |> Graphics.open_graph;
  Graphics.set_window_title "Tetris";
  Graphics.set_line_width 2;
  Graphics.moveto left lower;
  Graphics.lineto right lower;
  Graphics.lineto right upper;
  Graphics.lineto left upper;
  Graphics.lineto left lower

let display_tile tile = 
  Graphics.set_color (Tile.get_color tile);
  Graphics.fill_rect (Tile.get_x tile) (Tile.get_y tile) scale scale

let display_shape shape = failwith "unimplemented"

let delete_rows () = failwith "unimplemented"

let refresh () = Graphics.close_graph (); setup ()