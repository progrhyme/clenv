. lib/util.shrc

T_SUB "split_string" ((
  T_SUB "split by space" ((
    split_string "foo bar baz"
    t_is "${split_array[0]}" "foo"
    t_is "${split_array[1]}" "bar"
    t_is "${split_array[2]}" "baz"
  ))

  T_SUB "split by comma" ((
    split_string "foo,bar,,baz" "," ret_array
    t_is ${ret_array[0]} "foo"
    t_is ${ret_array[1]} "bar"
    t_is ${ret_array[2]} "baz"
  ))
))

# vim:set ft=sh :
