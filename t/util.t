. lib/util.shrc

(
  t_substart "split_string"
  (
    t_substart "split by space"
    split_string "foo bar baz"
    t_is "${split_array[0]}" "foo"
    t_is "${split_array[1]}" "bar"
    t_is "${split_array[2]}" "baz"
    t_subclose
  )
  t_subend "split by space"

  (
    t_substart "split by comma"
    split_string "foo,bar,,baz" "," ret_array
    t_is ${ret_array[0]} "foo"
    t_is ${ret_array[1]} "bar"
    t_is ${ret_array[2]} "baz"
    t_subclose
  )
  t_subend "split by comma"
  t_subclose
)
t_subend "split_string"

# vim:set ft=sh :
