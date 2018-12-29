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
