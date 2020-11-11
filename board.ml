(* [scale] defines the size of the game board and the tiles *)
let scale = Tile.tile_length

(* [left_offset] defines the width between the left side of the window and 
   left side of the board *)
let left_offset = 70

(* [bottom_offset] defines the height between the bottom of the window and 
   bottom of the board *)
let bottom_offset = 70

(* [right_offset] defines the width between the right side of the board and 
   right side of the window *)
let right_offset = 70

(** [top_offset] defines the height between the top of the board and the 
    top of the window *)
let top_offset = 70

(* [x_dim] is the width of the tetris board *)
let x_dim = 10

(* [y_dim] is the height of the tetris board *)
let y_dim = 20

(* [outline_width] is the width of the line drawing the outline of the board. 
   In order for coordinates to work out perfectly in edge tiles 
   [outline_width] should be an even number.*)
let outline_width = 4

(* [gridline_width] is the width of the line drawing the inside grid of 
   the board *)
let gridline_width = 1

let tile_array = Array.make y_dim (Array.make x_dim None)

let highest_y = Array.make x_dim 0

(** [setup ()] opens a Graphics window and draws the board outline for Tetris.
    The board is 10x20 blocks where each block is a square with width and 
    height both equal to [scale] pixels.*)
let setup () = 
  (* Draws the board outline *)
  let lower = bottom_offset in 
  let upper = lower + y_dim * scale + 
              (y_dim - 1) * gridline_width + outline_width in 
  let left = left_offset in
  let right = left + x_dim * scale + 
              (x_dim - 1) * gridline_width + outline_width in
  let width = right + right_offset in
  let height = upper + top_offset in 
  " " ^ (string_of_int width) ^ "x" ^ (string_of_int height) 
  |> Graphics.open_graph;
  Graphics.set_window_title "Tetris";
  Graphics.set_line_width outline_width;
  Graphics.moveto left lower;
  Graphics.lineto right lower;
  Graphics.lineto right upper;
  Graphics.lineto left upper;
  Graphics.lineto left lower;
  (* Draws the board grid *)
  Graphics.set_line_width gridline_width;
  for i = 1 to x_dim - 1 do 
    let x = left + i * (scale + gridline_width) + outline_width / 2 in
    Graphics.moveto x lower;
    Graphics.lineto x upper
  done;
  for i = 1 to y_dim - 1 do 
    let y = lower + i * (scale + gridline_width) + outline_width / 2 in
    Graphics.moveto left y;
    Graphics.lineto right y
  done


(* Functions for displaying different assets of the game *)

let draw_square color tile_x tile_y = 
  let x = left_offset + tile_x * scale + 
          (tile_x + 1) * gridline_width  + outline_width / 2 in
  let y = bottom_offset + tile_y * scale + 
          (tile_y + 1) * gridline_width + outline_width / 2 in
  Graphics.set_color color;
  let fit_scale = scale - gridline_width in
  Graphics.fill_rect x y fit_scale fit_scale

let display_tile tile = 
  let x = Tile.get_x tile in
  let y = Tile.get_y tile in
  draw_square (Tile.get_color tile) x y;
  let row = Array.get tile_array y in
  row.(x) <- Some Tile.t

let erase_tile tile = 
  let x = Tile.get_x tile in
  let y = Tile.get_y tile in
  draw_square (Graphics.rgb 255 255 255) x y;
  let row = Array.get tile_array y in
  row.(x) <- None

let rec display_each_tile = function
  | [] -> ()
  | tile::t -> display_tile tile; display_each_tile t

let display_shape shape = shape |> Shapes.get_tiles |> display_each_tile

let rec erase_each_tile = function
  | [] -> ()
  | tile::t -> erase_tile tile; erase_each_tile t

let erase_shape shape = shape |> Shapes.get_tiles |> erase_each_tile

let display_score score = 
  Graphics.set_color 0;
  Graphics.moveto (left_offset / 2) (bottom_offset + 21 * scale + scale / 2);
  Graphics.draw_string ("Score: " ^ string_of_int score)

let rec full_row row sum =
  match row with
  | [] -> sum
  | h::t -> begin
      match h with 
      | None -> full_row t sum
      | Some Tile.t -> full_row t sum + 1
    end

let erase_row row y = failwith "unimplemented"


(* NOTE: I think delete rows will eventually need to take in a parameter, 
   probably the y-coordinate of the row it's deleting*)
let delete_rows board = 
  for y = 0 to y_dim - 1 do
    let row = board.(y) in
    let sum = full_row row 0 in
    match sum with
    | x_dim -> erase_row row y
  done

let refresh () = Graphics.close_graph (); setup ()