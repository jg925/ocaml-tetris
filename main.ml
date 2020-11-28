


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

let move_shape key_press = 
  let current_shape = !shape_ref in
  let next_shape = 
    match key_press with 
    | 'f' -> Shapes.move_l current_shape
    | 'h' -> Shapes.move_r current_shape
    | 't' -> Shapes.rotate_l current_shape
    | 'y' -> Shapes.rotate_r current_shape
    | 'b' -> Shapes.fall current_shape
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
  shape_ref := (generate_new_shape ());
  draw_shape None !shape_ref


let f_end () = ()


let main () = 
  try
    new_falling_shape ();
    while true do
      try
        let s = Graphics.wait_next_event [Graphics.Key_pressed] in
        move_shape s.Graphics.key;
      with 
      | Shapes.DoneFalling -> 
        new_falling_shape ();
      | Tilearray.End -> raise Tilearray.End
    done
  with
  | Tilearray.End -> f_end ()


let start () = 
  Board.setup ();
  Board.display_score 0;
  main ()



let pause () = ()