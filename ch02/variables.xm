x = 3
x = 4
z = x + y

languages = "OCaml,Perl,C++,C"

let:
  language_list = String.split languages ~on=','
dashed_languages = String.concat ~sep:"=" language_list

// alternatively
dashed_languages = String.concat ~sep:"=" language_list
where:
  language_list = String.split languages ~on=','

let:
  languages = String.split languages ~on=','
dashed_languages = String.concat ~sep:"=" language

area_of_ring inner_radius outer_radius:
  pi = acos (-1.)
  area_of_circle r = pi *. r *. r
  area_of_circle outer_radius -. area_of_circle inner_radius

area_of_ring 1. 3.

area_of_ring inner_radius outer_radius:
  pi = acos (-1.)
  area_of_circle r = pi *. r *. r
  pi = 0.
  area_of_circle outer_radius -. area_of_circle inner_radius

// pattern matching
(ints, strings) = List.unzip [(1, "one"), (2, "two"), (3, "three")]

upcase_first_entry line:
  (first & rest) = String.split ~on=',' line
  String.concat ~sep="," (String.uppercase first & rest)

upcase_first_entry line:
  match String.split ~on=',' line:
    [] : assert false
    first & rest : String.concat ~sep="," (String.uppercase first & rest)

// anonymous functions

function x: x + 1

(function x: x + 1) 7

List.map ~f=(function x: x + 1) [1, 2, 3]

increments = [(function x : x + 1), (function x : x + 2)]
List.map ~f=(function g : g 5) increments

plusone = function x: x + 1

plusone x: x + 1

// Multiargument functions

abs_diff x y:
  abs (x - y)

abs_diff = function x:
  function y:
    abs (x - y)

dist_from_3 = abs_diff 3

abs_diff = function x y: abs (x - y)

abs_diff (x, y): abs (x - y)

// Recursive functions
recursive: find_first_stutter list:
  match list:
    [] | [_] : None
    x & y & tl :
      if x == y then Some x else find_first_stutter (y & tl)

recursive:
  is_even x:
    if x == 0 then true else is_odd (x - 1)
  is_odd x:
    if x == 0 then false else is_even (x - 1)

// Prefix & Infix
Int.max 3 4
3 + 4

(+) 3 4
List.map ~f=((+) 3) [4, 5, 6]

(+!) (x1, y1) (x2, y2):
  (x1 + x2, y1 + y2)

(***) x y: (x ** y) ** y

path = "/usr/bin:/usr/local/bin:/bin:/sbin"
String.split ~on=':' path \
  |> List.dedup ~compare=String.compare \
  |> List.iter ~f=print_endline

let:
  split_path = String.split ~on=':' path
  deduped_path = List.dedup ~compare=String.compare split_path
List.iter ~f=print_endline deduped_path

List.iter ~f=print_endline ["Two", "lines"]

List.iter ~f=print_endline

// Declaring functions with Match

some_or_zero: match:
  Some x: x
  None: 0

some_or_zero num_opt:
  match num_opt:
    Some x: x
    None: 0

some_or_default default: match:
  Some x: x
  None: default

// Labeled Arguments
ratio ~num ~denom:
  float num /. float denom

num = 3
denom = 4
ratio ~num ~denom

// Higher order functions and labels

apply_to_tuple f (first, second):
  f ~first ~second

apply_to_tuple2 f (first, second):
  f ~second ~first

divide ~first ~second:
  first / second

// divide can be used with apply_to_tuple but not apply_to_tuple2
