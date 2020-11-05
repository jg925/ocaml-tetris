(* [scale] defines the size of the game board and the tiles *)

let scale = Tile.tile_length
(* [left_offset] defines the width between the left side of the window and 
   left side of the board *)
let left_offset = 70

(* [bottom_offset] defines the height between the bottom of the window and 
   bottom of the board *)
let bottom_offset = 100

(* [right_offset] defines the width between the right side of the board and 
   right side of the window *)
let right_offset = 70

(* [top_offset] defines the height between the top of the board and the 
   top of the window *)
let top_offset = 100

(* [setup ()] opens a Graphics window and draws the board outline for Tetris.
   The board is 10x20 blocks where each block is a square with width and 
   height both equal to [scale] pixels.*)
let setup () =  
  let lower = bottom_offset in 
  let upper = lower + 20 * scale in 
  let left = left_offset in
  let right = left + 10 * scale in
  let width = right + right_offset in
  let height = upper + top_offset in 
  " " ^ (string_of_int width) ^ "x" ^ (string_of_int height) |> Graphics.open_graph;
  Graphics.set_window_title "Tetris";
  Graphics.set_line_width 3;
  Graphics.moveto left lower;
  Graphics.lineto right lower;
  Graphics.lineto right upper;
  Graphics.lineto left upper;
  Graphics.lineto left lower;
  Graphics.set_line_width 1;
  for i = 1 to 10 do 
    let x = left + i * scale in
    Graphics.moveto x lower;
    Graphics.lineto x upper
  done;
  for i = 1 to 20 do 
    let y = lower + i * scale in
    Graphics.moveto left y;
    Graphics.lineto right y
  done

let display_tile tile = 
  let x = left_offset + scale * (Tile.get_x tile) in
  let y = bottom_offset + scale * (Tile.get_y tile) in
  Graphics.set_color (Tile.get_color tile);
  Graphics.fill_rect x y scale scale

let display_shape shape = failwith "unimplemented"

(* NOTE: I think delete rows will eventually need to take in a parameter, 
   probably the y-coordinate of the row it's deleting*)
let delete_rows () = failwith "unimplemented"

let refresh () = Graphics.close_graph (); setup ()