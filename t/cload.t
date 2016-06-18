. shrc.d/cload.shrc

T_SUB "cload_path_push" ((
  CLOAD_PATH=
  cload_path_push /lib
  t_is $CLOAD_PATH "/lib"
  cload_path_push /usr/lib
  t_is $CLOAD_PATH "/lib:/usr/lib"
))

T_SUB "cload_path_unshift" ((
  CLOAD_PATH=
  cload_path_unshift /lib
  t_is $CLOAD_PATH "/lib"
  cload_path_unshift /usr/lib
  t_is $CLOAD_PATH "/usr/lib:/lib"
))

T_SUB "cload_path_del" ((
  CLOAD_PATH="/usr/lib:/lib"
  cload_path_del /foo
  t_is $CLOAD_PATH "/usr/lib:/lib"
  cload_path_del /lib
  t_is $CLOAD_PATH "/usr/lib"
  cload_path_del /usr/lib
  t_ng $CLOAD_PATH
))

# vim:set ft=sh :
