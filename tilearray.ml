exception End

let x_dim = 10

let y_dim = 24


let tile_array = Array.make (y_dim * x_dim) None

let score = ref 0

let high_scores = Array.make 5 0

let update_high_score new_score = 
  let scores = 
    new_score :: (Array.to_list high_scores)
    |> List.sort compare 
    |> List.rev
  in 
  for i = 0 to (Array.length high_scores - 1) do 
    high_scores.(i) <- List.nth scores i done

(** [array_index x y] calculates the index in [tile_array] corresponding to 
    x coordinate [x] and y coordinate [y]. *)
let array_index x y = y * x_dim + x

let set x y value = 
  if y > y_dim - 4 
  then raise End
  else
    let index = array_index x y in
    tile_array.(index) <- value

let get x y = 
  let index = array_index x y in
  tile_array.(index)



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

let update_score rows = 
  let num_rows = List.length rows in 
  let points = 
    if num_rows = 1
    then 40
    else if num_rows = 2
    then 100
    else if num_rows = 3
    then 300
    else if num_rows = 4
    then 1200
    else 0 in 
  score := !score + points


let delete_rows ys = 
  let uniq_ys = List.sort_uniq compare ys in
  let rows_to_delete = find_completed_rows [] uniq_ys in
  update_score rows_to_delete;
  shift_rows rows_to_delete



let clear () = 
  for x = 0 to y_dim * x_dim - 1 do
    tile_array.(x) <- None
  done