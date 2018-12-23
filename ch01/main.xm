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


