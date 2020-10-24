open OUnit2
open Main
open Tile
open Shapes
open Board
(*insert tests here*)

let tile_tests = 
  [

  ]

let shapes_tests = 
  [

  ]

let suite = 
  "test suite for tetris" >::: List.flatten [
    tile_tests;
    shapes_tests;
  ] 

let _ = run_test_tt_main suite