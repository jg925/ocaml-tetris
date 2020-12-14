open OUnit2
open Main
open Tile
open Tilearray
open Shapes
open Board

(* For the purposes of this test file, (5,5) is considered to be the origin. *)

let test_tile_origin = Tile.make_tile 5 5 0 0 0
let test_tile_down1 = Tile.make_tile 5 4 0 0 0
let test_tile_left1 = Tile.make_tile 4 5 0 0 0
let test_tile_right1 = Tile.make_tile 6 5 0 0 0
let test_tile_down1_left1 = Tile.make_tile 4 4 0 0 0
let test_tile_down1_right1 = Tile.make_tile 6 4 0 0 0

(* Making Tile Lists for shapes w/ anchor (5,5) and orientation 0 *)
(*  | 'I' -> gen_tile_list coord_list 25 206 230 []
    | 'J' -> gen_tile_list coord_list 25 39 230 []
    | 'L' -> gen_tile_list coord_list 230 138 25 []
    | 'T' -> gen_tile_list coord_list 155 25 230 [] 
    | 'Z' -> gen_tile_list coord_list 230 25 25 []
    | 'S' -> gen_tile_list coord_list 39 230 25 []
    | 'O' -> gen_tile_list coord_list 230 230 25 [] *)
(*| 'I' -> [(x - 2, y); (x - 1, y); (x, y); (x + 1, y)]
  | 'J' -> [(x - 1, y + 1); (x - 1, y); (x, y); (x + 1, y)]
  | 'L' -> [(x + 1, y + 1); (x + 1, y); (x, y); (x - 1, y)]
  | 'T' -> [(x, y + 1); (x - 1, y); (x, y); (x + 1, y)]
  | 'Z' -> [(x - 1, y + 1); (x, y + 1); (x, y); (x + 1, y)]
  | 'S' -> [(x - 1, y); (x, y); (x, y + 1); (x + 1, y + 1)]
  | 'O' -> [(x, y); (x + 1, y); (x + 1, y - 1); (x, y - 1)] *)
let tile_Ia = Tile.make_tile 3 5 25 206 230
let tile_Ib = Tile.make_tile 4 5 25 206 230
let tile_Ic = Tile.make_tile 5 5 25 206 230
let tile_Id = Tile.make_tile 6 5 25 206 230

let tile_Ja = Tile.make_tile 4 6 25 39 230
let tile_Jb = Tile.make_tile 4 5 25 39 230
let tile_Jc = Tile.make_tile 5 5 25 39 230
let tile_Jd = Tile.make_tile 6 5 25 39 230

let tile_La = Tile.make_tile 6 6 230 138 25
let tile_Lb = Tile.make_tile 6 5 230 138 25
let tile_Lc = Tile.make_tile 5 5 230 138 25
let tile_Ld = Tile.make_tile 4 5 230 138 25

let tile_Ta = Tile.make_tile 5 6 155 25 230
let tile_Tb = Tile.make_tile 4 5 155 25 230
let tile_Tc = Tile.make_tile 5 5 155 25 230
let tile_Td = Tile.make_tile 6 5 155 25 230

let tile_Za = Tile.make_tile 4 6 230 25 25
let tile_Zb = Tile.make_tile 5 6 230 25 25
let tile_Zc = Tile.make_tile 5 5 230 25 25
let tile_Zd = Tile.make_tile 6 5 230 25 25

let tile_Sa = Tile.make_tile 4 5 39 230 25
let tile_Sb = Tile.make_tile 5 5 39 230 25
let tile_Sc = Tile.make_tile 5 6 39 230 25
let tile_Sd = Tile.make_tile 6 6 39 230 25

let tile_Oa = Tile.make_tile 5 5 230 230 25
let tile_Ob = Tile.make_tile 6 5 230 230 25
let tile_Oc = Tile.make_tile 6 4 230 230 25
let tile_Od = Tile.make_tile 5 4 230 230 25

let tile_get_x_test name tile expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Tile.get_x tile) ~printer:string_of_int)

let tile_get_y_test name tile expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Tile.get_y tile) ~printer:string_of_int)

let tile_get_color name tile expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Tile.get_color tile))

let tile_fall_test name tile expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Tile.fall tile))

let tile_left_test name tile expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Tile.move_left tile))

let tile_right_test name tile expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Tile.move_right tile))

let tile_tests = 
  [
    tile_get_x_test "origin x is 5" test_tile_origin 5;
    tile_get_y_test "origin y is 5" test_tile_origin 5;
    tile_get_color "color of I is 25 206 230" tile_Ia (Graphics.rgb 25 206 230);
    tile_get_color "color of J is 25 39 230" tile_Ja (Graphics.rgb 25 39 230);
    tile_fall_test "origin fall 1" test_tile_origin test_tile_down1;
    tile_left_test "origin to the left 1" test_tile_origin test_tile_left1;
    tile_right_test "origin to the right 1" test_tile_origin test_tile_right1;
    tile_left_test "fall 1 to the left 1" 
      test_tile_down1 test_tile_down1_left1;
    tile_right_test "fall 1 to the right 1" 
      test_tile_down1 test_tile_down1_right1;
  ]

let cmp_lists lst1 lst2 =
  lst1 = lst2

let pp_tile tile = 
  "(" ^ string_of_int (Tile.get_x tile) ^ 
  "," ^ string_of_int (Tile.get_y tile) ^ ") "
  ^ "color: " ^ string_of_int (Tile.get_color tile)

let pp_shape (shape : Shapes.t) =
  let pp_elts pp_elt lst =
    let rec loop n acc = function
      | [] -> acc
      | [h] -> acc ^ pp_elt h
      | h1 :: (h2 :: t as t') ->
        if n = 100 then acc ^ "..."  (* stop printing long list *)
        else loop (n + 1) (acc ^ (pp_elt h1) ^ "; ") t'
    in loop 0 "" lst
  in "Tiles: [" ^ pp_elts pp_tile (Shapes.get_tiles shape) ^ "]"

let pp_list shape =
  let pp_elts pp_elt lst =
    let rec loop n acc = function
      | [] -> acc
      | [h] -> acc ^ pp_elt h
      | h1 :: (h2 :: t as t') ->
        if n = 100 then acc ^ "..."  (* stop printing long list *)
        else loop (n + 1) (acc ^ (pp_elt h1) ^ "; ") t'
    in loop 0 "" lst
  in "[" ^ pp_elts pp_tile shape ^ "]"


let tetris_I = Shapes.make_shape 'I' (5,5) 0
let tetris_J = Shapes.make_shape 'J' (5,5) 0
let tetris_L = Shapes.make_shape 'L' (5,5) 0
let tetris_T = Shapes.make_shape 'T' (5,5) 0
let tetris_S = Shapes.make_shape 'S' (5,5) 0
let tetris_Z = Shapes.make_shape 'Z' (5,5) 0
let tetris_O = Shapes.make_shape 'O' (5,5) 0

let rightwall_T = Shapes.make_shape 'T' (Tilearray.x_dim-1,5) 270
let rightwallkicked_T_r = Shapes.make_shape 'T' (8,5) 0
let rightwallkicked_T_l = Shapes.make_shape 'T' (8,5) 180
let leftwall_T = Shapes.make_shape 'T' (0,5) 90
let leftwallkicked_T_r = Shapes.make_shape 'T' (1,5) 180
let leftwallkicked_T_l = Shapes.make_shape 'T' (1,5) 0

let rightwall_Z = Shapes.make_shape 'Z' (Tilearray.x_dim-1,5) 270
let rightwallkicked_Z_r = Shapes.make_shape 'Z' (8,5) 0
let rightwallkicked_Z_l = Shapes.make_shape 'Z' (8,5) 180
let leftwall_Z = Shapes.make_shape 'Z' (0,5) 90
let leftwallkicked_Z_r = Shapes.make_shape 'Z' (1,5) 180
let leftwallkicked_Z_l = Shapes.make_shape 'Z' (1,5) 0

let rightwall_S = Shapes.make_shape 'S' (Tilearray.x_dim-1,5) 270
let rightwallkicked_S_r = Shapes.make_shape 'S' (8,5) 0
let rightwallkicked_S_l = Shapes.make_shape 'S' (8,5) 180
let leftwall_S = Shapes.make_shape 'S' (0,5) 90
let leftwallkicked_S_r = Shapes.make_shape 'S' (1,5) 180
let leftwallkicked_S_l = Shapes.make_shape 'S' (1,5) 0

let rightwall_J = Shapes.make_shape 'J' (Tilearray.x_dim-1,5) 270
let rightwallkicked_J_r = Shapes.make_shape 'J' (8,5) 0
let rightwallkicked_J_l = Shapes.make_shape 'J' (8,5) 180
let leftwall_J = Shapes.make_shape 'J' (0,5) 90
let leftwallkicked_J_r = Shapes.make_shape 'J' (1,5) 180
let leftwallkicked_J_l = Shapes.make_shape 'J' (1,5) 0

let rightwall_L = Shapes.make_shape 'L' (Tilearray.x_dim-1,5) 270
let rightwallkicked_L_r = Shapes.make_shape 'L' (8,5) 0
let rightwallkicked_L_l = Shapes.make_shape 'L' (8,5) 180
let leftwall_L = Shapes.make_shape 'L' (0,5) 90
let leftwallkicked_L_r = Shapes.make_shape 'L' (1,5) 180
let leftwallkicked_L_l = Shapes.make_shape 'L' (1,5) 0

let rightwall_I_1 = Shapes.make_shape 'I' (Tilearray.x_dim-1,5) 270
let rightwallkicked_I_1_r = Shapes.make_shape 'I' (8,5) 0
let rightwallkicked_I_1_l = Shapes.make_shape 'I' (7,5) 180
let rightwall_I_2 = Shapes.make_shape 'I' (Tilearray.x_dim-1,5) 90
let rightwallkicked_I_2_r = Shapes.make_shape 'I' (7,5) 180
let rightwallkicked_I_2_l =  Shapes.make_shape 'I' (8,5) 0

let leftwall_I_1 = Shapes.make_shape 'I' (0,5) 270
let leftwallkicked_I_1_r = Shapes.make_shape 'I' (2,5) 0
let leftwallkicked_I_1_l = Shapes.make_shape 'I' (1,5) 180
let leftwall_I_2 = Shapes.make_shape 'I' (0,5) 90
let leftwallkicked_I_2_r = Shapes.make_shape 'I' (1,5) 180
let leftwallkicked_I_2_l = Shapes.make_shape 'I' (2,5) 0

let rightwall_O = Shapes.make_shape 'O' (Tilearray.x_dim-2,5) 0
let leftwall_O = Shapes.make_shape 'O' (0,5) 0

let tetris_I_neg90 = Shapes.make_shape 'I' (5,5) ~-90
let tetris_I_270 = Shapes.make_shape 'I' (5,5) 270
let tetris_I_180 = Shapes.make_shape 'I' (5,5) 180
let tetris_I_90 = Shapes.make_shape 'I' (5,5) 90
let tetris_I_360 = Shapes.make_shape 'I' (5,5) 360

let tetris_J_neg90 = Shapes.make_shape 'J' (5,5) ~-90
let tetris_J_270 = Shapes.make_shape 'J' (5,5) 270
let tetris_J_180 = Shapes.make_shape 'J' (5,5) 180
let tetris_J_90 = Shapes.make_shape 'J' (5,5) 90
let tetris_J_360 = Shapes.make_shape 'J' (5,5) 360

let tetris_L_neg90 = Shapes.make_shape 'L' (5,5) ~-90
let tetris_L_270 = Shapes.make_shape 'L' (5,5) 270
let tetris_L_180 = Shapes.make_shape 'L' (5,5) 180
let tetris_L_90 = Shapes.make_shape 'L' (5,5) 90
let tetris_L_360 = Shapes.make_shape 'L' (5,5) 360

let tetris_T_neg90 = Shapes.make_shape 'T' (5,5) ~-90
let tetris_T_270 = Shapes.make_shape 'T' (5,5) 270
let tetris_T_180 = Shapes.make_shape 'T' (5,5) 180
let tetris_T_90 = Shapes.make_shape 'T' (5,5) 90
let tetris_T_360 = Shapes.make_shape 'T' (5,5) 360

let tetris_I_l = Shapes.make_shape 'I' (4,5) 0
let tetris_I_r = Shapes.make_shape 'I' (6,5) 0

let get_x_test name shape expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Shapes.get_x shape) ~printer:string_of_int)

let get_y_test name shape expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Shapes.get_y shape) ~printer:string_of_int)

let get_tiles_test name shape expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Shapes.get_tiles shape) ~printer:pp_list)

let make_shape_invalid test_name name anchor orientation : test =
  test_name >:: (fun _ ->
      assert_raises (Shapes.BadName name) 
        (fun _ -> Shapes.make_shape name anchor orientation))

let move_l_test name shape expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Shapes.move_l shape) ~printer:pp_shape)

let move_r_test name shape expected_output : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Shapes.move_r shape) ~printer:pp_shape)

let rotate_l_test name shape expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Shapes.rotate_l shape) 
        ~printer:pp_shape)

let rotate_r_test name shape expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Shapes.rotate_r shape) ~printer:pp_shape)

let shapes_tests = 
  [
    get_x_test "I origin" tetris_I 5;
    get_x_test "J origin" tetris_J 5;
    get_x_test "L origin" tetris_L 5;
    get_x_test "T origin" tetris_T 5;
    get_x_test "O origin" tetris_O 5;
    get_x_test "Z origin" tetris_Z 5;
    get_x_test "S origin" tetris_S 5;
    get_y_test "I origin" tetris_I 5;
    get_y_test "J origin" tetris_J 5;
    get_y_test "L origin" tetris_L 5;
    get_y_test "T origin" tetris_T 5;
    get_y_test "O origin" tetris_O 5;
    get_y_test "Z origin" tetris_Z 5;
    get_y_test "S origin" tetris_S 5;
    make_shape_invalid "nonexistent shape" 'A' (5,5) 0;

    get_tiles_test "I" tetris_I [tile_Ia; tile_Ib; tile_Ic; tile_Id];
    get_tiles_test "J" tetris_J [tile_Ja; tile_Jb; tile_Jc; tile_Jd];
    get_tiles_test "L" tetris_L [tile_La; tile_Lb; tile_Lc; tile_Ld];
    get_tiles_test "T" tetris_T [tile_Ta; tile_Tb; tile_Tc; tile_Td];
    get_tiles_test "Z" tetris_Z [tile_Za; tile_Zb; tile_Zc; tile_Zd];
    get_tiles_test "S" tetris_S [tile_Sa; tile_Sb; tile_Sc; tile_Sd];
    get_tiles_test "O" tetris_O [tile_Oa; tile_Ob; tile_Oc; tile_Od];

    rotate_l_test "I 0 - 90" tetris_I tetris_I_neg90;
    rotate_l_test "I 270 - 90" tetris_I_270 tetris_I_180;
    rotate_l_test "I 180 - 90" tetris_I_180 tetris_I_90;
    rotate_l_test "I 360 - 90" tetris_I_360 tetris_I_270;
    rotate_r_test "I 0 + 90" tetris_I tetris_I_90;
    rotate_r_test "I 90 + 90" tetris_I_90 tetris_I_180;
    rotate_r_test "I 180 + 90" tetris_I_180 tetris_I_270;
    rotate_r_test "I 270 + 90" tetris_I_270 tetris_I_360;

    rotate_l_test "J 0 - 90" tetris_J tetris_J_neg90;
    rotate_l_test "J 270 - 90" tetris_J_270 tetris_J_180;
    rotate_l_test "J 180 - 90" tetris_J_180 tetris_J_90;
    rotate_l_test "J 360 - 90" tetris_J_360 tetris_J_270;
    rotate_r_test "J 0 + 90" tetris_J tetris_J_90;
    rotate_r_test "J 90 + 90" tetris_J_90 tetris_J_180;
    rotate_r_test "J 180 + 90" tetris_J_180 tetris_J_270;
    rotate_r_test "J 270 + 90" tetris_J_270 tetris_J_360;

    rotate_l_test "L 0 - 90" tetris_L tetris_L_neg90;
    rotate_l_test "L 270 - 90" tetris_L_270 tetris_L_180;
    rotate_l_test "L 180 - 90" tetris_L_180 tetris_L_90;
    rotate_l_test "L 360 - 90" tetris_L_360 tetris_L_270;
    rotate_r_test "L 0 + 90" tetris_L tetris_L_90;
    rotate_r_test "L 90 + 90" tetris_L_90 tetris_L_180;
    rotate_r_test "L 180 + 90" tetris_L_180 tetris_L_270;
    rotate_r_test "L 270 + 90" tetris_L_270 tetris_L_360;

    rotate_l_test "T 0 - 90" tetris_T tetris_T_neg90;
    rotate_l_test "T 270 - 90" tetris_T_270 tetris_T_180;
    rotate_l_test "T 180 - 90" tetris_T_180 tetris_T_90;
    rotate_l_test "T 360 - 90" tetris_T_360 tetris_T_270;
    rotate_r_test "T 0 + 90" tetris_T tetris_T_90;
    rotate_r_test "T 90 + 90" tetris_T_90 tetris_T_180;
    rotate_r_test "T 180 + 90" tetris_T_180 tetris_T_270;
    rotate_r_test "T 270 + 90" tetris_T_270 tetris_T_360;

    (* wall kick tests *)
    rotate_l_test "T right wall, left turn" rightwall_T rightwallkicked_T_l;
    rotate_r_test "T right wall, right turn" rightwall_T rightwallkicked_T_r;
    rotate_l_test "T left wall, left turn" leftwall_T leftwallkicked_T_l;
    rotate_r_test "T left wall, right turn" leftwall_T leftwallkicked_T_r;

    rotate_l_test "Z right wall, left turn" rightwall_Z rightwallkicked_Z_l;
    rotate_r_test "Z right wall, right turn" rightwall_Z rightwallkicked_Z_r;
    rotate_l_test "Z left wall, left turn" leftwall_Z leftwallkicked_Z_l;
    rotate_r_test "Z left wall, right turn" leftwall_Z leftwallkicked_Z_r;

    rotate_l_test "S right wall, left turn" rightwall_S rightwallkicked_S_l;
    rotate_r_test "S right wall, right turn" rightwall_S rightwallkicked_S_r;
    rotate_l_test "S left wall, left turn" leftwall_S leftwallkicked_S_l;
    rotate_r_test "S left wall, right turn" leftwall_S leftwallkicked_S_r;

    rotate_l_test "J right wall, left turn" rightwall_J rightwallkicked_J_l;
    rotate_r_test "J right wall, right turn" rightwall_J rightwallkicked_J_r;
    rotate_l_test "J left wall, left turn" leftwall_J leftwallkicked_J_l;
    rotate_r_test "J left wall, right turn" leftwall_J leftwallkicked_J_r;

    rotate_l_test "L right wall, left turn" rightwall_L rightwallkicked_L_l;
    rotate_r_test "L right wall, right turn" rightwall_L rightwallkicked_L_r;
    rotate_l_test "L left wall, left turn" leftwall_L leftwallkicked_L_l;
    rotate_r_test "L left wall, right turn" leftwall_L leftwallkicked_L_r;

    rotate_r_test "I right wall anch @ 1, right turn" rightwall_I_1 
      rightwallkicked_I_1_r;
    rotate_l_test "I right wall anch @ 1, left turn" rightwall_I_1 
      rightwallkicked_I_1_l;
    rotate_r_test "I right wall anch @ 2, right turn" rightwall_I_2 
      rightwallkicked_I_2_r;
    rotate_l_test "I right wall anch @ 2, left turn" rightwall_I_2 
      rightwallkicked_I_2_l;

    rotate_r_test "I left wall anch @ 1, right turn" leftwall_I_1 
      leftwallkicked_I_1_r;
    rotate_l_test "I left wall anch @ 1, left turn" leftwall_I_1 
      leftwallkicked_I_1_l;
    rotate_r_test "I left wall anch @ 2, right turn" leftwall_I_2 
      leftwallkicked_I_2_r;
    rotate_l_test "I left wall anch @ 2, left turn" leftwall_I_2 
      leftwallkicked_I_2_l;

    move_l_test "I shift left 1" tetris_I tetris_I_l;
    move_r_test "I shift right 1" tetris_I tetris_I_r;

    (* Move L + R edge wall cases *)
    move_r_test "I right wall" rightwall_I_1 rightwall_I_1;
    move_r_test "J right wall" rightwall_J rightwall_J;
    move_r_test "L right wall" rightwall_L rightwall_L;
    move_r_test "S right wall" rightwall_S rightwall_S;
    move_r_test "Z right wall" rightwall_Z rightwall_Z;
    move_r_test "T right wall" rightwall_T rightwall_T;
    move_r_test "O right wall" rightwall_O rightwall_O;

    move_l_test "O left wall" leftwall_O leftwall_O;
    move_l_test "T left wall" leftwall_T leftwall_T;
    move_l_test "Z left wall" leftwall_Z leftwall_Z;
    move_l_test "S left wall" leftwall_S leftwall_S;
    move_l_test "L left wall" leftwall_L leftwall_L;
    move_l_test "J left wall" leftwall_J leftwall_J;
    move_l_test "I left wall" leftwall_I_1 leftwall_I_1;

  ]

let suite = 
  "test suite for tetris" >::: List.flatten [
    tile_tests;
    shapes_tests;
  ] 

let _ = run_test_tt_main suite