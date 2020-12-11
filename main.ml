

let generate_new_shape () =
  let rand_element lst =
    Random.self_init ();
    let n = Random.int (List.length lst) in List.nth lst n in
  let poss_shape_type = 
    ['I'; 'J'; 'L'; 'T'; 'Z'; 'S'; 'O'] in
  let decided_shape_type = rand_element poss_shape_type in
  let x = Tilearray.x_dim/2 - 1 in
  let y = Tilearray.y_dim - 3 in
  let coords = 
    if decided_shape_type = 'I' 
    then (x + 1, y + 1)
    else if decided_shape_type = 'O'
    then (x, y + 1)
    else (x, y) in
  Shapes.make_shape decided_shape_type coords 0

let shape_ref = ref (generate_new_shape ())


let erase_previous previous_shape = 
  match previous_shape with
  | None -> ()
  | Some shape -> shape |> Board.erase_shape

let draw_shape previous_shape current_shape = 
  erase_previous previous_shape;
  current_shape |> Board.display_shape

let move_shape key_press key_array = 
  let current_shape = !shape_ref in
  let next_shape = 
    match key_press with 
    | lk when lk = key_array.(0) -> Shapes.move_l current_shape
    | rk when rk = key_array.(1) -> Shapes.move_r current_shape
    | rot_lk when rot_lk = key_array.(2) -> Shapes.rotate_l current_shape
    | rot_rk when rot_rk = key_array.(3) -> Shapes.rotate_r current_shape
    | fk when fk = key_array.(4) -> Shapes.fall current_shape
    | _ -> current_shape
  in draw_shape (Some current_shape) next_shape;
  shape_ref := next_shape

let fall_shape _ = 
  let current_shape = !shape_ref in
  let next_shape = Shapes.fall current_shape in
  draw_shape (Some current_shape) next_shape;
  shape_ref := next_shape;
  ignore (Unix.alarm 1)

let new_falling_shape () = 
  ignore (Sys.signal Sys.sigalrm (Sys.Signal_handle fall_shape));
  ignore (Unix.alarm 1);
  shape_ref := generate_new_shape ();
  draw_shape None !shape_ref

let rec get_tile_ys acc = function
  | [] -> acc
  | tile :: t -> get_tile_ys (Tile.get_y tile :: acc) t

let get_ys shape = get_tile_ys [] (Shapes.get_tiles shape)


let redraw_tiles () = 
  for ind = 0 to (Tilearray.y_dim * Tilearray.x_dim) - 1 do
    let entry = Tilearray.tile_array.(ind) in 
    match entry with
    | None -> 
      let x = ind mod Tilearray.x_dim in 
      let y = (ind - x)/Tilearray.x_dim in 
      Board.erase_coords x y
    | Some tile -> Board.display_tile tile
  done

let rec main () = 
  try
    new_falling_shape ();
    while true do
      try
        let k = Graphics.read_key () in
        move_shape k !Board.key_array;
      with 
      | Shapes.DoneFalling -> 
        let ys = get_ys !shape_ref in
        Tilearray.delete_rows ys;
        redraw_tiles ();
        Board.display_score !Tilearray.score;
        new_falling_shape ();
      | Tilearray.End -> raise Tilearray.End
    done
  with
  | Tilearray.End -> 
    while true do 
      let k = Graphics.read_key () in
      if k = 'm' then 
        begin
          Board.refresh ();
          Tilearray.score := 0;
          Board.display_score !Tilearray.score;
          Tilearray.clear ();
          main ()
        end
      else ()
    done
let start () = 
  ANSITerminal.(print_string [red] "\n\nWelcome to Tetris for Ocaml!\n
  Please enter settings to have the game most suited toward your preferences.");
  Board.setup ();
  Board.display_score !Tilearray.score;
  main () 



let pause () = ()