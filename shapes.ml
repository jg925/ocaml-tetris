(*insert shapes defs here*)
type anchor_tile = Tile.t
(** [type t] is a generic type for each tetris block with a name and a list 
    of Tiles to create the desired tetris block.
    The [name] can be one of the following chars: I, J, L, T, Z, S, O*)
type t = {
  name : char;
  anchor : anchor_tile;
  tile_list : Tile.t list;
  orientation : int;
}

exception BadName of char

let makeShape (name : char) (anchor : anchor_tile) = 
  let tile_list : Tile.t list = 
    match name with
    | 'I' -> []
    | 'J' -> []
    | 'L' -> []
    | 'T' -> []
    | 'Z' -> []
    | 'S' -> []
    | 'O' -> []
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