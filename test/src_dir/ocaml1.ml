(* really stupid way to calculate a number in the fibonacci sequence *)

let rec fib n =
  match n with
    | 0 -> 1
    | 1 -> 1
    | _ -> fib (n-2) + fib (n-1)
;;
