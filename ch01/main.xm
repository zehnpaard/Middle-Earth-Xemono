open Core.std // open directives remain the same and OCaml modules are accessible

3 + 4
8 / 3
3.5 +. 6.  // One day, modular implicits...
30_000_000 / 300_000
sqrt 9.

x = 3 + 4
y = x + x

x7 = 3 + 4
x_plus_y = x + y
x' = x + 1
_x' = x' + x'

square x: x * x

ratio x y:
  Float.of_int x /. Float.of_int y

sum_if_true test first second:
  x = cond:
    test first: first
    else: 0

  y = cond:
    test second: second
    else: 0

  x + y

sum_if_true' test first second:
  (if test first then first else 0) + (if test second then second else 0)

sum_if_true (test :: int -> bool) (x :: int) (y :: int) :: int :
  (if test x then x else 0) + (if test y then y else 0)

first_if_true test x y:
  if test x then x else y

long_string s:
  String.length s > 6

first_if_true long_string "short" "loooooong"

big_number x: x > 3

first_if_true big_number 4 3

// Tuples

a_tuple = (3, "three")
another_tuple = (3, "four", 5.)

(x, y) = a_tuple

// Lists

languages = ["OCaml", "Perl", "C", "Xemono"]
List.length languages
List.map languages ~f=String.length
[1, 2, 3]
1 & (2 & (3 & []))
1 & 2 & 3 & []

[1, 2, 3] ++ [4, 5, 6] // If only we had modular implicits...

my_favorite_language (my_favorite & the_rest):
  my_favorite

my_favorite_language languages:
  match languages:
    first & the_rest: first
    [] : "OCaml"

recursive: sum l:
  match l:
    [] : 0
    hd & tl : hd + sum tl

sum [1, 2, 3]

recursive: destutter list:
  match list:
    [] : []
    [hd] : [hd]
    hd1 & hd2 & tl :
      cond:
        hd1 = h2: destutter (hd2 & tl)
        else: h1 & destutter (hd2 & tl)


//Options

divide x y:
  if y == 0 then None else Some (x / y)

// alternatively

divide x y:
  cond:
    y == 0: None
    else: Some (x / y)

log_entry maybe_time message:
  time = match maybe_time:
    Some x: x
    None: Time.now ()
  Time.to_sec_string time ^ " -- " ^ message // if only modular implicits...

// Records

record type point2d:
  x :: float
  y :: float

// alternatively

type point2d:  { x :: float, y :: float}

p = { x : 3., y : -4. }

magnitude { x : x_pos, y : y_pos } :
  sqrt ( x_pos ** 2. +. y_pos ** 2.)

magnitude {x, y}:
  sqrt (x ** 2. +. y ** 2.)

distance v1 v2:
  magnitude { x : v1.x - v2.x, y : v1.y - v2.y }

record type circle_desc:
  center :: point2d
  radius :: float

record type rect_desc:
  lower_left :: point2d
  width :: float
  height :: float

record type segment_desc:
  endpoint1 :: point2d
  endpoint2 :: point2d

// Variants

type scene_element:
  Circle circle_desc
  Rect rect_desc
  Segment segment_desc

is_inside_scene_element point scene_element:
  match scene_element:
    Circle { center, radius }:
      distance center point < radius
    Rect { lower_left, width, height }:
      point.x > lower_left.x && point.x < lower_left.x +. width \
      && point.y > lower_left.y && point.y < lower_left.y +. height
    Segment { endpoint1, endpoint2 }: false

is_inside_scene point scene:
  List.exists scene (~f=function el: is_inside_scene_element point el)

// Arrays
numbers = [| 1, 2, 3, 4 |]
numbers.(2) <- 4 // if only modular implicits, we will have numbers[2] <- 4

// Mutable Records
record type running_sum:
  mutable sum :: float
  mutable sum_sq :: float
  mutable samples :: int

// alternatively
type running_sum: { mutable sum :: float, ...}

mean rsum:
  rsum.sum /. float rsum.samples

stdev rsum:
  sqrt (   rsum.sum_sq /. float rsum.samples
        -. (rsum.sum /. float rsum.samples) ** 2.) // Indentation ignored inside parens

create (): { sum:0., sum_sq:0., samples=0 }
update rsum x:
  rsum.samples <- rsum.samples + 1
  rsum.sum <- rsum.sum +. x
  rsum.sum_sq <- rsum.sum_sq +. x *. x

// Refs

x = { contents: 0 }
x.contents <- x.contents + 1

x = ref 0
!x
x := !x + 1
!x

type 'a ref:
  mutable contents :: 'a

ref x:
  { contents : x }
(!) r:
  r.contents
(:=) r x:
  r.contents <- x

sum list:
  s = ref 0
  List.iter list ~f=(function x: s := !s + x)
  !s

// For/While

permute array:
  length = Array.length array
  for i = 0 to length - 2:
    j = i + 1 + Random.int (length - i - 1)
    tmp = array.(i)
    array.(i) <- array.(j)
    array.(j) <- tmp

ar = Array.init 20 ~f=(function i: i)
permute ar

find_first_negative_entry array:
  pos = ref 0
  while:
    !pos < Array.length array && array.(!pos) >= 0
  do:
    pos := !pos + 1
  if !pos == Array.length array then None else Some !pos

find_first_negative_entry array: // Possible out-of-bounds error
  pos = ref 0
  while:
    pos_is_good = !pos < Array.length array
    element_is_non_negative = array.(!pos) >= 0
    pos_is_good && element_is_non_negative
  do:
    pos := !pos + 1
  if !pos = Array.length array then None else Some !pos

// Standalone program

open Core.Std

recursive: read_and_accumulate accum:
  line = In_channel.input_line In_channel.stdin
  match line:
    None: accum
    Some x: read_and_accumulate (accum +. Float.of_string x)

main ():
  printf "Total: %F\n" (read_and_accumulate 0.)
