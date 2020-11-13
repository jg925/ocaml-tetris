
type anchor = (int * int)

type t = {
  name : char;
  anchor : anchor;
  tile_list : Tile.t list;
  orientation : int;
}

exception BadName of char
exception BadShape of t



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

let modulo_360 orient = let modded_orient = orient mod 360 in 
  if modded_orient < 0 
  then modded_orient + 360 
  else modded_orient

let gen_coord_list name anchor_coords orientation =
  let orientation = orientation |> modulo_360 in
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
          | 'I' -> [(x, y - 2); (x, y - 1); (x, y); (x, y + 1)]
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
  let coord_list = gen_coord_list name anchor orientation in
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
    orientation = orientation
  }



(* functions for getting properties of shapes *)

let get_x shape = fst shape.anchor 

let get_y shape = snd shape.anchor 

let get_tiles shape = shape.tile_list



(* functions for generating new shapes from old ones *)

let rec move_each_tile acc dir = function
  | [] -> acc
  | tile :: t -> let f = (if dir = "l" 
                          then Tile.move_left 
                          else Tile.move_right) in
    move_each_tile (acc @ [f tile]) dir t

let rec check_shape_tiles tiles =
  match tiles with
  | [] -> true
  | h :: t -> begin
      let x = Tile.get_x h in 
      let y = Tile.get_y h in
      if x < 0 || x > Tilearray.x_dim-1 || y < 0 then false
      else if Tilearray.get x y = None then
        check_shape_tiles t 
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
  if check_shape_tiles new_tile_list = false then shape
  else {shape with anchor = new_anchor; 
                   tile_list = new_tile_list}

let move_l shape = move_lr shape "l"

let move_r shape = move_lr shape "r"


let rotate_l shape = 
  let new_shape = make_shape shape.name shape.anchor 
      (shape.orientation - 90 |> modulo_360) in 
  if check_shape_tiles new_shape.tile_list = false then shape
  else new_shape

let rotate_r shape = 
  let new_shape = make_shape shape.name shape.anchor 
      (shape.orientation + 90 |> modulo_360) in 
  if check_shape_tiles new_shape.tile_list = false then shape
  else new_shape

let fall shape = 
  let new_tile_list = List.map Tile.fall shape.tile_list in  
  if check_shape_tiles new_tile_list = false then shape
  else {shape with anchor = (match shape.anchor with (x, y) -> (x, y - 1));
         tile_list = new_tile_list}

let drop shape = failwith "unimplemented"
