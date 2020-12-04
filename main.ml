
exception End

let key_array = [|'f'; 'h'; 't'; 'y'; 'b'|]

let generate_new_shape () =
  let rand_element lst =
    Random.self_init ();
    let n = Random.int (List.length lst) in List.nth lst n in
  let poss_shape_type = 
    [('I', (5, 17));
     ('J', (5, 17));
     ('L', (5, 17));
     ('T', (5, 17));
     ('Z', (5, 17));
     ('S', (5, 17));
     ('O', (5, 17))] in
  let poss_orient = [0; 90; 270; 360] in 
  let decided_shape_type = rand_element poss_shape_type in
  Shapes.make_shape 
    (fst decided_shape_type) 
    (snd decided_shape_type) 
    (rand_element poss_orient)

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


let f_end () = ()


let main () = 
  try
    ignore (Sys.signal Sys.sigalrm (Sys.Signal_handle fall_shape));
    ignore (Unix.alarm 1);
    while true do
      try
        let shape_falling = true in
        shape_ref := (generate_new_shape ());
        draw_shape None !shape_ref;
        while shape_falling do
          let s = Graphics.wait_next_event [Graphics.Key_pressed] in
          move_shape s.Graphics.key;
        done
      with 
      | End -> raise End
    done
  with
  | End -> f_end ()


let start () = 
  Board.setup ();
  Board.display_score 0;
  main ()



let pause () = ()