(* [scale] defines the size of the game board and the tiles *)
let scale = Tile.tile_length


let key_array = ref [|'f'; 'h'; 't'; 'g'; 'b'; 'r'|]
let ctl_array = ref [|"Move Left"; "Move Right"; "Rotate CW"; 
                      "Rotate CCW"; "Fall Faster"|]
(* [left_offset] defines the width between the left side of the window and 
   left side of the board *)
let left_offset = 150

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
let x_dim = Tilearray.x_dim

(* [y_dim] is the height of the tetris board *)
let y_dim = Tilearray.y_dim

(* [outline_width] is the width of the line drawing the outline of the board. 
   In order for coordinates to work out perfectly in edge tiles 
   [outline_width] should be an even number.*)
let outline_width = 4

(* [gridline_width] is the width of the line drawing the inside grid of 
   the board *)
let gridline_width = 1


let pp_array pp_elt arr =
  let pp_elts arr =
    let rec loop n acc = function
      | [] -> acc
      | [h] -> acc ^ pp_elt h
      | h1 :: (h2 :: t as t') ->
        if n = 100 then acc ^ "..."  (* stop printing long list *)
        else loop (n + 1) (acc ^ (pp_elt h1) ^ "; ") t'
    in loop 0 "" arr
  in "[|" ^ pp_elts (Array.to_list arr) ^ "|]"


let set_settings () = 
  let explode str =
    let rec exp a b =
      if a < 0 then b
      else exp (a - 1) (str.[a] :: b)
    in
    (exp (String.length str - 1) []) |> Array.of_list in

  let rec do_key_settings kmode () = 
    ANSITerminal.(print_string [red] 
                    ("Your current keybinds are " ^ kmode ^".\n
                    Do you want to change?\n> "));
    match read_line () with
    | "Yes" |"y" | "Y" | "yes" -> begin
        ANSITerminal.(print_string [red] 
                        ("Choose the keys you would like for \
                          Left, Right, Rotate CCW, Rotate CW, \
                          Restart, and Fall Faster):\n
                        1. adwsxr\n
                        2. jlik,r\n
                        3. fhtgbr\n"));
        match read_int () with
        | 1 -> key_array := "adwsxr" |> explode
        | 2 -> key_array := "jlik,r" |> explode
        | 3 -> key_array := "fhtgbr" |> explode
        | _ -> ANSITerminal.(print_string [blue] "invalid input\n"); 
          do_key_settings (pp_array (fun x -> Char.escaped x) !key_array) ()
      end; ()
    | "No"  |"n" | "N" | "no" -> 
      ANSITerminal.(print_string [red]
                      "Enjoy the game!"); ()
    | _ -> ANSITerminal.(print_string [blue] "invalid input\n"); 
      do_key_settings (pp_array (fun x -> Char.escaped x) !key_array) ()  in
  do_key_settings (pp_array (fun x -> Char.escaped x) !key_array) ()

let lower () = bottom_offset

let upper () = lower () + y_dim * scale + 
               (y_dim - 1) * gridline_width + outline_width

let left () = left_offset

let right () = left () + x_dim * scale + 
               (x_dim - 1) * gridline_width + outline_width

let width () = right () + right_offset

let height () = upper () + top_offset


let display_welcome_screen () = 
  let width = width () in
  let height = height () in 

  " " ^ (string_of_int width) ^ "x" ^ (string_of_int height) 
  |> Graphics.open_graph;
  Graphics.set_window_title "Tetris";
  Graphics.set_color (Graphics.rgb 0 0 0);

  Graphics.moveto (width / 2 - 55) ((height * 2) / 3);
  Graphics.draw_string "Welcome to Tetris";
  Graphics.moveto (width / 2 - 70) ((height * 2) / 3 - 30);
  Graphics.draw_string "Press any key to begin"


let display_game_over_screen () = 
  let width = width () in
  let height = height () in 

  Graphics.clear_graph ();
  Graphics.set_color (Graphics.rgb 0 0 0);

  Graphics.moveto (width / 2 - 30) ((height * 2) / 3);
  Graphics.draw_string "Game Over!";
  Graphics.moveto (width / 2 - 90) ((height * 2) / 3 - 30);
  Graphics.draw_string ("Press "^ Char.escaped !key_array.(5) ^" to play another round")


(** [setup ()] opens a Graphics window and draws the board outline for Tetris.
    The board is 10x20 blocks where each block is a square with width and 
    height both equal to [scale] pixels.*)
let setup_board () = 
  (* Draws the board outline *)
  let lower = lower () in 
  let upper = upper () in 
  let left = left () in
  let right = right () in

  Graphics.clear_graph ();
  Graphics.set_color (Graphics.rgb 0 0 0);
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

let display_controls (control_config:char array ref) =
  Graphics.set_color 0;
  Graphics.moveto (left_offset / 5) (y_dim * scale / 2);
  Graphics.draw_string ("Controls: ");
  for i = 0 to Array.length !ctl_array - 1 do 
    Graphics.moveto (left_offset / 5) ((y_dim * scale / 2) - (i + 1) * 20);
    Graphics.draw_string (!ctl_array.(i) ^ ": " 
                          ^ Char.escaped (!key_array.(i)))
  done

(* functions for displaying different assets of the game *)

let draw_square bevel color tile_x tile_y = 
  let x = left_offset + tile_x * scale + 
          (tile_x + 1) * gridline_width  + outline_width / 2 in
  let y = bottom_offset + tile_y * scale + 
          (tile_y + 1) * gridline_width + outline_width / 2 in
  Graphics.set_color color;
  let fit_scale = scale - gridline_width in
  Graphics.fill_rect x y fit_scale fit_scale;
  if bevel
  then 
    let inner_scale = fit_scale - 10 in 
    let inner_x = x + 5 in
    let inner_y = y + 5 in 
    (* sides *)
    Graphics.set_color (color * 2);
    Graphics.fill_poly [|(x, y); 
                         (inner_x, inner_y); 
                         (inner_x, inner_y + inner_scale); 
                         (x, y + fit_scale)|];
    Graphics.fill_poly [|(x + fit_scale, y); 
                         (inner_x + inner_scale, inner_y); 
                         (inner_x + inner_scale, inner_y + inner_scale); 
                         (x + fit_scale, y + fit_scale)|];
    (* bottom *)
    Graphics.set_color (color * 7);
    Graphics.fill_poly [|(x, y); 
                         (x + fit_scale, y); 
                         (inner_x + inner_scale, inner_y);
                         (inner_x, inner_y)|];
    (* top *)
    Graphics.set_color (color * 3);
    Graphics.fill_poly [|(x, y + fit_scale); 
                         (x + fit_scale, y + fit_scale); 
                         (inner_x + inner_scale, inner_y + inner_scale);
                         (inner_x, inner_y + inner_scale)|]
  else ()

let display_tile tile bevel color = 
  let x = Tile.get_x tile in
  let y = Tile.get_y tile in
  draw_square bevel color x y 

let erase_coords x y = 
  draw_square false (Graphics.rgb 255 255 255) x y 

let erase_tile tile = 
  let x = Tile.get_x tile in
  let y = Tile.get_y tile in
  erase_coords x y

let rec display_each_tile shadow = function
  | [] -> ()
  | tile::t -> 
    if shadow 
    then display_tile tile false (Graphics.rgb 200 200 200)
    else display_tile tile true (Tile.get_color tile); 
    display_each_tile shadow t

let display_shape shape = shape 
                          |> Shapes.get_tiles 
                          |> display_each_tile false

let display_shadow shape = shape 
                           |> Shapes.get_tiles 
                           |> display_each_tile true

let rec erase_each_tile = function
  | [] -> ()
  | tile::t -> erase_tile tile; erase_each_tile t

let erase_shape shape = shape |> Shapes.get_tiles |> erase_each_tile

let display_score score = 
  Graphics.set_color (Graphics.rgb 255 255 255);
  Graphics.fill_rect 0 bottom_offset 
    (left_offset - outline_width) (y_dim * scale + top_offset);
  Graphics.set_color 0;
  Graphics.moveto (left_offset / 5) (bottom_offset + y_dim * scale);
  Graphics.draw_string ("Score: " ^ string_of_int score)


let display_high_scores scores = 
  Graphics.set_color 0;
  Graphics.moveto (left_offset / 5) (y_dim * scale);
  Graphics.draw_string ("High Score Board");
  for i = 0 to List.length scores - 1 do 
    Graphics.moveto (left_offset / 5) (y_dim * scale - (i + 1) * 20);
    Graphics.draw_string (string_of_int (i + 1) ^ ". " 
                          ^ string_of_int (List.nth scores i))
  done


let check_if_fallen shape =
  let tile_list = Shapes.get_tiles shape in
  let rec helper_check = function
    | [] -> false
    | h :: t -> begin
        match (Tile.get_x h, Tile.get_y h) with
        | (x, 1) -> true
        | (x, y) -> helper_check t
      end
  in helper_check tile_list

let rec full_row row sum =
  match row with
  | [] -> sum
  | h::t -> begin
      match h with 
      | None -> full_row t sum
      | Some h -> full_row t sum + 1
    end


(** [check_rows board] checks each row in [board] to see if any are full.
    Returns a list of ints representing the indices at which the rows are 
    full. *)
let check_rows board =
  let rows = ref [] in
  for y = 0 to y_dim - 1 do
    let row = board.(y) in
    let sum = full_row row 0 in
    match sum with
    | x_dim -> rows := y :: !rows
  done;
  !rows


let refresh () = 
  Graphics.clear_graph (); 
  setup_board ()