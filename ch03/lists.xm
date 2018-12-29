[1, 2, 3]

1 & (2 & (3 & []))

1 & 2 & 3 & []

empty = []
3 & empty
"three" & empty

l = 1 & 2 & 3 & []
m = 0 & l

recursive: sum l:
  match l:
    []:  0
    head & tail:  head + sum tail

sum [1, 2, 3]

sum []

recursive: drop_value l to_drop:
  match l:
    [] : []
    head & tail: cond:
      head == to_drop:
        drop_value tail to_drop
      else:
        head & drop_value tail to_drop

recursive: drop_value l to_drop:
  match l:
    [] : []
    head & tail:
      dropped_tail = drop_value tail to_drop
      cond:
        head == to_drop:  dropped_tail
        else:  head & dropped_tail

recursive: drop_zero l:
  match l:
    []:  []
    0 & tail:  drop_zero tail
    head & tail:  head & drop_zero tail

// Performance

plus_one_match x:
  match x:
    0:  1
    1:  2
    2:  3
    _:  x + 1

plus_one_cond x:
  cond:
    x == 0:  1
    x == 1:  2
    x == 2:  3
    else:  x + 1

open Core_bench.Std

run_bench tests:
  display = Textutils.Ascii_table.Display.column_titles
  Bench.bench ~ascii_table=true ~display tests

test1 = Bench.Test.create ~name="plus_one_match" f
where:  f = function (): ignore (plus_one_match 10)

test2 = Bench.Test.create ~name="plus_one_cond" f
where:  f = function (): ignore (plus_one_cond 10)

run_bench [test1, test2]
