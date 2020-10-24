open OUnit2
open Main
open Tile
open Shapes
open Board

let tile_tests = 
  [

  ]

let tetris_I = Shapes.make_shape 'I' (0,0)
let tetris_J = Shapes.make_shape 'J' (0,0)
let tetris_L = Shapes.make_shape 'L' (0,0)
let tetris_T = Shapes.make_shape 'T' (0,0)
let tetris_S = Shapes.make_shape 'S' (0,0)
let tetris_Z = Shapes.make_shape 'Z' (0,0)
let tetris_O = Shapes.make_shape 'O' (0,0)

let get_x_test name shape expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Shapes.get_x shape) ~printer:string_of_int)

let get_y_test name shape expected_output : test =
  name >:: (fun _ ->
      assert_equal expected_output (Shapes.get_y shape) ~printer:string_of_int)

let make_shape_invalid test_name name anchor : test =
  test_name >:: (fun _ ->
      assert_raises (Shapes.BadName name) 
        (fun _ -> Shapes.make_shape name anchor))

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
    make_shape_invalid "nonexistent shape" 'A' (0,0);
  ]

let suite = 
  "test suite for tetris" >::: List.flatten [
    tile_tests;
    shapes_tests;
  ] 

let _ = run_test_tt_main suite