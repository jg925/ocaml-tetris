open OUnit2
open Main
open Tile
open Tilearray
open Shapes
open Board

let tile_tests = 
  [

  ]

(*
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
*)


let tetris_I = Shapes.make_shape 'I' (0,0) 0
let tetris_J = Shapes.make_shape 'J' (0,0) 0
let tetris_L = Shapes.make_shape 'L' (0,0) 0
let tetris_T = Shapes.make_shape 'T' (0,0) 0
let tetris_S = Shapes.make_shape 'S' (0,0) 0
let tetris_Z = Shapes.make_shape 'Z' (0,0) 0
let tetris_O = Shapes.make_shape 'O' (0,0) 0

let tetris_I_neg90 = Shapes.make_shape 'I' (0,0) ~-90
let tetris_I_270 = Shapes.make_shape 'I' (0,0) 270
let tetris_I_180 = Shapes.make_shape 'I' (0,0) 180
let tetris_I_90 = Shapes.make_shape 'I' (0,0) 90
let tetris_I_360 = Shapes.make_shape 'I' (0,0) 360

let tetris_I_l = Shapes.make_shape 'I' (-1,0) 0
let tetris_I_r = Shapes.make_shape 'I' (1,0) 0

let get_x_test name shape expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Shapes.get_x shape) ~printer:string_of_int)

let get_y_test name shape expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Shapes.get_y shape) ~printer:string_of_int)

let make_shape_invalid test_name name anchor orientation : test =
  test_name >:: (fun _ ->
      assert_raises (Shapes.BadName name) 
        (fun _ -> Shapes.make_shape name anchor orientation))

let move_l_test name shape expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Shapes.move_l shape))

let move_r_test name shape expected_output : test =
  name >:: (fun _ -> 
      assert_equal expected_output (Shapes.move_r shape))

let rotate_l_test name shape expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Shapes.rotate_l shape))

let rotate_r_test name shape expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Shapes.rotate_r shape))

let shapes_tests = 
  [
    get_x_test "I origin" tetris_I 0;
    get_x_test "J origin" tetris_J 0;
    get_x_test "L origin" tetris_L 0;
    get_x_test "T origin" tetris_T 0;
    get_x_test "O origin" tetris_O 0;
    get_x_test "Z origin" tetris_Z 0;
    get_x_test "S origin" tetris_S 0;
    get_y_test "I origin" tetris_I 0;
    get_y_test "J origin" tetris_J 0;
    get_y_test "L origin" tetris_L 0;
    get_y_test "T origin" tetris_T 0;
    get_y_test "O origin" tetris_O 0;
    get_y_test "Z origin" tetris_Z 0;
    get_y_test "S origin" tetris_S 0;
    make_shape_invalid "nonexistent shape" 'A' (0,0) 0;
    rotate_l_test "I 0 - 90" tetris_I tetris_I_neg90;
    rotate_l_test "I 270 - 90" tetris_I_270 tetris_I_180;
    rotate_l_test "I 180 - 90" tetris_I_180 tetris_I_90;
    rotate_l_test "I 360 - 90" tetris_I_360 tetris_I_270;
    rotate_r_test "I 0 + 90" tetris_I tetris_I_90;
    rotate_r_test "I 90 + 90" tetris_I_90 tetris_I_180;
    rotate_r_test "I 180 + 90" tetris_I_180 tetris_I_270;
    rotate_r_test "I 270 + 90" tetris_I_270 tetris_I_360;
    move_l_test "I shift left 1" tetris_I tetris_I_l;
    move_r_test "I shift right 1" tetris_I tetris_I_r;

  ]

let suite = 
  "test suite for tetris" >::: List.flatten [
    tile_tests;
    shapes_tests;
  ] 

let _ = run_test_tt_main suite