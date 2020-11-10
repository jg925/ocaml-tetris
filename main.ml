let test_tile = Tile.make_tile 5 17 100 0 0

let test_I_0 = Shapes.make_shape 'I' (1, 1) 0
let test_J_0 = Shapes.make_shape 'J' (1, 5) 0
let test_L_0 = Shapes.make_shape 'L' (1, 10) 0
let test_T_0 = Shapes.make_shape 'T' (1, 15) 0
let test_Z_0 = Shapes.make_shape 'Z' (5, 1) 0
let test_S_0 = Shapes.make_shape 'S' (5, 7) 0
let test_O_0 = Shapes.make_shape 'O' (5, 15) 0

let test_I_90 = Shapes.make_shape 'I' (1, 1) 90
let test_J_90 = Shapes.make_shape 'J' (1, 5) 90
let test_L_90 = Shapes.make_shape 'L' (1, 10) 90
let test_T_90 = Shapes.make_shape 'T' (1, 15) 90
let test_Z_90 = Shapes.make_shape 'Z' (5, 1) 90
let test_S_90 = Shapes.make_shape 'S' (5, 7) 90
let test_O_90 = Shapes.make_shape 'O' (5, 15) 90

let test_I_180 = Shapes.make_shape 'I' (1, 1) 180
let test_J_180 = Shapes.make_shape 'J' (1, 5) 180
let test_L_180 = Shapes.make_shape 'L' (1, 10) 180
let test_T_180 = Shapes.make_shape 'T' (1, 15) 180
let test_Z_180 = Shapes.make_shape 'Z' (5, 1) 180
let test_S_180 = Shapes.make_shape 'S' (5, 7) 180
let test_O_180 = Shapes.make_shape 'O' (5, 15) 180

let test_I_270 = Shapes.make_shape 'I' (1, 2) 270
let test_J_270 = Shapes.make_shape 'J' (1, 5) 270
let test_L_270 = Shapes.make_shape 'L' (1, 10) 270
let test_T_270 = Shapes.make_shape 'T' (1, 15) 270
let test_Z_270 = Shapes.make_shape 'Z' (5, 1) 270
let test_S_270 = Shapes.make_shape 'S' (5, 7) 270
let test_O_270 = Shapes.make_shape 'O' (5, 15) 270


let erase_previous previous_shape = 
  match previous_shape with
  | None -> ()
  | Some shape -> shape |> Board.erase_shape

let start () = 
  let score = 0 in
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
  Board.setup ();


  let current_shape = 
    let decided_shape_type = rand_element poss_shape_type in
    ref 
      (Shapes.make_shape 
         (fst decided_shape_type) 
         (snd decided_shape_type) 
         (rand_element poss_orient)) in


  Board.display_score score;
  let rec game_loop loops current_shape previous_shape =
    match loops with 
    | 0 -> ()
    | _ -> 
      erase_previous previous_shape;
      current_shape |> Board.display_shape;
      Unix.sleep 1;
      game_loop (loops - 1) (Shapes.fall current_shape) (Some current_shape)
  in 
  game_loop 15 !current_shape None

let pause () = ()