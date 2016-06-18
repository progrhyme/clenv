. shrc.d/cload.shrc

T_SUB "cload_search" ((
  CLOAD_PATH=tmp
  for _f in a b.sh c.shrc; do
    touch tmp/test__${_f}
  done
  t_is $(cload_search test__a) "tmp/test__a" "search test__a"
  t_is $(cload_search test__b) "tmp/test__b.sh" "search test__b"
  t_is $(cload_search test__b.sh) "tmp/test__b.sh" "search test__b.sh"
  t_is $(cload_search test__c) "tmp/test__c.shrc" "search test__c"
  t_is $(cload_search test__c.shrc) "tmp/test__c.shrc" "search test__c.shrc"
  t_ng "$(cload_search __no_such_shrc)" "no file"
  for _f in a b.sh c.shrc; do
    rm -f tmp/test__${_f}
  done
))

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