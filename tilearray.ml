exception End

let x_dim = 10

let y_dim = 24

(** [tile_array] is a Tile.t option array that keeps track of which coordinates 
    of the board have a tile in them.*)
let tile_array = Array.make (y_dim * x_dim) None

let array_index x y = y * x_dim + x

let set x y value = 
  if y > y_dim - 4 
  then raise End
  else
    let index = array_index x y in
    tile_array.(index) <- value

let rec find_completed_rows acc = function
  | [] -> acc
  | y :: t -> 
    let start = array_index 0 y in
    let unfilled_tiles = Array.to_list (Array.sub tile_array start x_dim)
                         |> List.filter (fun x -> x = None) in
    if unfilled_tiles = []
    then find_completed_rows (y::acc) t
    else find_completed_rows acc t

let rec reassign_array ind new_entries = 
  if ind = y_dim * x_dim 
  then () 
  else
    match new_entries with
    | [] -> tile_array.(ind) <- None; 
      reassign_array (ind + 1) new_entries
    | h :: t -> begin
        match h with
        | None -> 
          tile_array.(ind) <- None;
          reassign_array (ind + 1) t
        | Some tile ->
          tile_array.(ind) <- Some (Tile.set_y tile ((Tile.get_y tile) - 1));
          reassign_array (ind + 1) t
      end

let rec shift_rows = function
  | [] -> ()
  | y :: t -> 
    let start = array_index 0 (y + 1) in 
    let entries_to_shift = Array.to_list 
        (Array.sub tile_array start (y_dim * x_dim - start - 1)) in
    reassign_array (array_index 0 y) entries_to_shift;
    shift_rows t


let delete_rows ys = 
  let uniq_ys = List.sort_uniq compare ys in
  let rows_to_delete = find_completed_rows [] uniq_ys in
  shift_rows rows_to_delete


let get x y = 
  let index = array_index x y in
  tile_array.(index)

