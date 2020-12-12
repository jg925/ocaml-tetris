
type anchor = (int * int)

type t = {
  name : char;
  anchor : anchor;
  tile_list : Tile.t list;
  orientation : int;
}

exception BadName of char
exception BadShape of t
exception BadDirection of string

exception DoneFalling


(* functions for generating shapes *)

let rec gen_tile_list (coords : (int * int) list) (r : int) (g : int) 
    (b : int) tile_list = 
  match coords with
  | [] -> tile_list
  | h :: t -> begin 
      match h with
      | (a,b) -> begin 
          let x = a in
          let y = b in 
          let tile = Tile.make_tile x y r g b
          in gen_tile_list t r g b (tile :: tile_list)
        end
    end

let modulo_360 orient = 
  let modded_orient = orient mod 360 in 
  if modded_orient < 0 
  then modded_orient + 360 
  else modded_orient


(* RI: orientation must be 0, 60, 180, or 270 *)
let gen_coord_list name anchor_coords orientation =
  match anchor_coords with
  | (a,b) -> begin
      let x = a in
      let y = b in
      match orientation with
      | 0 -> begin
          match name with
          | 'I' -> [(x - 2, y); (x - 1, y); (x, y); (x + 1, y)]
          | 'J' -> [(x - 1, y + 1); (x - 1, y); (x, y); (x + 1, y)]
          | 'L' -> [(x + 1, y + 1); (x + 1, y); (x, y); (x - 1, y)]
          | 'T' -> [(x, y + 1); (x - 1, y); (x, y); (x + 1, y)]
          | 'Z' -> [(x - 1, y + 1); (x, y + 1); (x, y); (x + 1, y)]
          | 'S' -> [(x - 1, y); (x, y); (x, y + 1); (x + 1, y + 1)]
          | 'O' -> [(x, y); (x + 1, y); (x + 1, y - 1); (x, y - 1)]
          | _ -> raise (BadName name)
        end
      | 90 -> begin
          match name with
          | 'I' -> [(x, y + 2); (x, y + 1); (x, y); (x, y - 1)]
          | 'J' -> [(x + 1, y + 1); (x, y + 1); (x, y); (x, y - 1)]
          | 'L' -> [(x + 1, y - 1); (x, y - 1); (x, y); (x, y + 1)]
          | 'T' -> [(x + 1, y); (x, y + 1); (x, y); (x, y - 1)]
          | 'Z' -> [(x + 1, y + 1); (x + 1, y); (x, y); (x, y - 1)]
          | 'S' -> [(x, y + 1); (x, y); (x + 1, y); (x + 1, y - 1)]
          | 'O' -> [(x, y); (x + 1, y); (x + 1, y - 1); (x, y - 1)]
          | _ -> raise (BadName name) 
        end
      | 180 -> begin
          match name with
          | 'I' -> [(x + 2, y); (x + 1, y); (x, y); (x - 1, y)]
          | 'J' -> [(x + 1, y - 1); (x + 1, y); (x, y); (x - 1, y)]
          | 'L' -> [(x - 1, y - 1); (x - 1, y); (x, y); (x + 1, y)]
          | 'T' -> [(x, y - 1); (x + 1, y); (x, y); (x - 1, y)]
          | 'Z' -> [(x + 1, y - 1); (x, y - 1); (x, y); (x - 1, y)]
          | 'S' -> [(x + 1, y); (x, y); (x, y - 1); (x - 1, y - 1)]
          | 'O' -> [(x, y); (x + 1, y); (x + 1, y - 1); (x, y - 1)]
          | _ -> raise (BadName name)
        end
      | 270 -> begin
          match name with 
          | 'I' -> [(x, y + 1); (x, y); (x, y - 1); (x, y - 2)]
          | 'J' -> [(x - 1, y - 1); (x, y - 1); (x, y); (x, y + 1)]
          | 'L' -> [(x - 1, y + 1); (x, y + 1); (x, y); (x, y - 1)]
          | 'T' -> [(x - 1, y); (x, y - 1); (x, y); (x, y + 1)]
          | 'Z' -> [(x - 1, y - 1); (x - 1, y); (x, y); (x, y + 1)]
          | 'S' -> [(x, y - 1); (x, y); (x - 1, y); (x - 1, y + 1)]
          | 'O' -> [(x, y); (x + 1, y); (x + 1, y - 1); (x, y - 1)]
          | _ -> raise (BadName name)
        end
      | x -> []
    end

let make_shape (name : char) (anchor : anchor) (orientation : int) = 
  let orient = orientation |> modulo_360 in
  let coord_list = gen_coord_list name anchor orient in
  let tile_list : Tile.t list = 
    match name with
    | 'I' -> gen_tile_list coord_list 25 206 230 []
    | 'J' -> gen_tile_list coord_list 25 39 230 []
    | 'L' -> gen_tile_list coord_list 230 138 25 []
    | 'T' -> gen_tile_list coord_list 155 25 230 [] 
    | 'Z' -> gen_tile_list coord_list 230 25 25 []
    | 'S' -> gen_tile_list coord_list 39 230 25 []
    | 'O' -> gen_tile_list coord_list 230 230 25 []
    | _ -> raise (BadName name)
  in {
    name = name;
    anchor = anchor;
    tile_list = tile_list;
    orientation = orient
  }



(* functions for getting properties of shapes *)

let get_x shape = fst shape.anchor 

let get_y shape = snd shape.anchor 

let get_tiles shape = shape.tile_list

let index_of_anchor (tile_list : Tile.t list) anchor = 
  let rec index_helper (tile_list : Tile.t list) anchor ind = 
    match tile_list with 
    | [] -> ind 
    | h :: t -> begin 
        if (Tile.get_x h, Tile.get_y h) = anchor 
        then ind else index_helper t anchor (ind + 1)
      end
  in index_helper tile_list anchor 0

(* functions for generating new shapes from old ones *)

let rec move_each_tile acc dir = function
  | [] -> acc
  | tile :: t -> let f = (if dir = "l" 
                          then Tile.move_left 
                          else Tile.move_right) in
    move_each_tile (acc @ [f tile]) dir t

let rec check_shape_tiles = function
  | [] -> true
  | h :: t -> begin
      let x = Tile.get_x h in 
      let y = Tile.get_y h in
      if x < 0 || x > Tilearray.x_dim - 1 || y < 0 || y >= Tilearray.y_dim
      then false
      else if Tilearray.get x y = None 
      then check_shape_tiles t 
      else false
    end

let move_lr shape dir = 
  let new_anchor =
    match shape.anchor with
    | (x,y) -> begin 
        if dir = "l" then (x - 1, y) 
        else if dir = "r" then (x + 1, y)
        else raise (Failure "improper direction")
      end in 
  let new_tile_list = move_each_tile [] dir shape.tile_list in
  if check_shape_tiles new_tile_list = false 
  then shape
  else {shape with anchor = new_anchor; 
                   tile_list = new_tile_list}

let move_l shape = move_lr shape "l"

let move_r shape = move_lr shape "r"

(** [wall_kick shape] performs a wall kick on a rotated shape. *)
let wall_kick_rotation shape dir =
  let left_shape = move_l shape in 
  let right_shape = move_r shape in 
  match dir with 
  | "L" -> begin
      let rotated_shape = make_shape shape.name shape.anchor
          (shape.orientation - 90 |> modulo_360) in 
      let rotated_l_shape = make_shape left_shape.name left_shape.anchor
          (left_shape.orientation - 90 |> modulo_360) in 
      let rotated_r_shape = make_shape right_shape.name right_shape.anchor
          (right_shape.orientation - 90 |> modulo_360) in
      if check_shape_tiles rotated_shape.tile_list = true
      then rotated_shape
      else if check_shape_tiles rotated_l_shape.tile_list = true 
      then rotated_l_shape
      else if check_shape_tiles rotated_r_shape.tile_list = true 
      then rotated_r_shape
      else shape
    end
  | "R" -> begin
      let rotated_shape = make_shape shape.name shape.anchor
          (shape.orientation + 90 |> modulo_360) in 
      let rotated_l_shape = make_shape left_shape.name left_shape.anchor
          (left_shape.orientation + 90 |> modulo_360) in 
      let rotated_r_shape = make_shape right_shape.name right_shape.anchor
          (right_shape.orientation + 90 |> modulo_360) in
      if check_shape_tiles rotated_shape.tile_list = true
      then rotated_shape
      else if check_shape_tiles rotated_l_shape.tile_list = true 
      then rotated_l_shape
      else if check_shape_tiles rotated_r_shape.tile_list = true 
      then rotated_r_shape
      else shape
    end
  | _ -> raise (BadDirection dir)

and shift_block shape dir = 
  match shape.name with 
  | 'I' -> begin
      match shape.orientation with
      | 270 | 90 -> begin
          let x, y = shape.anchor in 
          let wall = if x = 0 then "L" 
            else if x = Tilearray.x_dim - 1 
            then "R" else "M" in 
          let ind_of_anchor = index_of_anchor shape.tile_list shape.anchor in 
          match wall with 
          | "L" -> begin 
              if ind_of_anchor = 1 then
                (shape |> move_l |> move_l, shape |> move_r)
              else if ind_of_anchor = 2 then 
                (shape |> move_l, shape |> move_r |> move_r)
              else raise (BadShape shape)
            end
          | "R" -> begin 
              if ind_of_anchor = 2 then
                (shape |> move_l |> move_l, shape |> move_r)
              else if ind_of_anchor = 1 then 
                (shape |> move_l, shape |> move_r |> move_r)
              else raise (BadShape shape)
            end
          | _ -> (move_l shape, move_r shape)
        end
      | 180 | 0 -> (move_l shape, move_r shape)
      | _ -> raise (BadShape shape)
    end
  | 'J' | 'L' | 'Z'
  | 'S' | 'O' | 'T' -> (move_l shape, move_r shape)
  | _ -> raise (BadName shape.name)

let rotate_l shape = wall_kick_rotation shape "L"

let rotate_r shape = wall_kick_rotation shape "R"

let rec set_tile_array = function
  | [] -> raise DoneFalling
  | tile :: t -> 
    let x = Tile.get_x tile in
    let y = Tile.get_y tile in
    Tilearray.set x y (Some tile);
    set_tile_array t

let fall shape = 
  (* Graphics.sound 7000 1000; *)
  let new_tile_list = List.map Tile.fall shape.tile_list in  
  if check_shape_tiles new_tile_list = false 
  then set_tile_array shape.tile_list
  else {shape with anchor = (match shape.anchor with (x, y) -> (x, y - 1));
         tile_list = new_tile_list}


let rec shape_shadow shape = 
  let new_tile_list = List.map Tile.fall shape.tile_list in  
  if check_shape_tiles new_tile_list = false 
  then shape
  else shape_shadow 
      {shape with anchor = 
                    (match shape.anchor with (x, y) -> (x, y - 1));
                  tile_list = new_tile_list}

(*
let rec drop shape = 
  drop (fall shape)
*)