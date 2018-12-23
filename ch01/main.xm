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
  x = if test first: first
  else: 0

  y = if test second: second
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
