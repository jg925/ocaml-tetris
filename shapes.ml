(*insert shapes defs here*)
type anchor_tile = Tile.t
(** [type t] is a generic type for each tetris block with a name and a list 
    of Tiles to create the desired tetris block.
    The [name] can be one of the following chars: I, J, L, T, Z, S, O
    The [orientation] is one of 0, 90, 180, 270 *)
type t = {
  name : char;
  anchor : anchor_tile;
  tile_list : Tile.t list;
  orientation : int;
}

exception BadName of char

let rec gen_tile_list (coords : (int * int) list) (r : int) (g : int) (b : int) tile_list = 
  match coords with
  | [] -> tile_list
  | h :: t -> begin 
      match h with
      | (a,b) -> begin 
          let x = a in
          let y = b in 
          let tile = Tile.create_tile x y r g b
          in gen_tile_list t r g b (tile :: tile_list)
        end
    end

let gen_coord_list name anchor_coords orientation =
  match anchor_coords with
  | (a,b) -> begin
      let x = a in
      let y = b in
      match orientation with
      | 0 -> begin
          match name with
          | 'I' -> [(x - 2, y); (x - 1, y); (x, y); (x + 1, y)]
          | 'J' -> [(x - 1, y + 1); (x + 1, y); (x, y); (x + 1, y)]
          | 'L' -> [(x + 1, y + 1); (x + 1, y); (x, y); (x - 1, y)]
          | 'T' -> [(x, y + 1); (x - 1, y); (x, y); (x + 1, y)]
          | 'Z' -> [(x - 1, y + 1); (x, y + 1); (x, y); (x + 1, y)]
          | 'S' -> [(x - 1, y - 1); (x, y); (x, y + 1); (x + 1, y + 1)]
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
          | 'J' -> [(x - 1, y); (x, y - 1); (x, y); (x, y + 1)]
          | 'L' -> [(x - 1, y + 1); (x, y + 1); (x, y); (x, y - 1)]
          | 'T' -> [(x - 1, y); (x, y - 1); (x, y); (x, y + 1)]
          | 'Z' -> [(x - 1, y - 1); (x - 1, y); (x, y); (x, y + 1)]
          | 'S' -> [(x, y - 1); (x, y); (x - 1, y); (x - 1, y + 1)]
          | 'O' -> [(x, y); (x + 1, y); (x + 1, y - 1); (x, y - 1)]
          | _ -> raise (BadName name)
        end
      | x -> []
    end

let makeShape (name : char) (anchor : anchor_tile) = 
  let anchor_coords = (Tile.get_x anchor, Tile.get_y anchor) in
  let coord_list = gen_coord_list name anchor_coords 0 in
  let tile_list : Tile.t list = 
    match name with
    | 'I' -> gen_tile_list coord_list 5 240 241 []
    | 'J' -> gen_tile_list coord_list 17 0 241 []
    | 'L' -> gen_tile_list coord_list 239 160 1 []
    | 'T' -> gen_tile_list coord_list 160 0 241 [] 
    | 'Z' -> gen_tile_list coord_list 240 0 1 []
    | 'S' -> gen_tile_list coord_list 2 240 0 []
    | 'O' -> gen_tile_list coord_list 240 240 0 []
    | _ -> raise (BadName name)
  in {
    name = name;
    anchor = anchor;
    tile_list = tile_list;
    orientation = 0
  }

let get_anchor_tile shape = shape.anchor 

let get_x shape = get_anchor_tile shape |> Tile.get_x

let get_y shape = get_anchor_tile shape |> Tile.get_y

let move_l shape = failwith "unimplemented"

let move_r shape = failwith "unimplemented"

let rotate_l shape = failwith "unimplemented"

let rotate_r shape = failwith "unimplemented"

let fall shape = failwith "unimplemented"

let drop shape = failwith "unimplemented"
