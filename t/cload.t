export CLENV_ROOT="$(pwd)"
export PATH="$(pwd)/shims:$(pwd)/bin:$PATH"
. shrc.d/cload.shrc

t::group "cload_search" ({
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
})

t::group "cload_path_push" ({
  CLOAD_PATH=
  cload_path_push /lib
  t_is $CLOAD_PATH "/lib"
  t::group "When push same dir" ({
    cload_path_push /lib
    t_is $CLOAD_PATH "/lib" "not pushed"
  })
  cload_path_push /usr/lib
  t_is $CLOAD_PATH "/lib:/usr/lib"
})

t::group "cload_path_unshift" ({
  CLOAD_PATH=
  cload_path_unshift /lib
  t_is $CLOAD_PATH "/lib"
  t::group "When unshift same dir" ({
    cload_path_unshift /lib
    t_is $CLOAD_PATH "/lib" "not unshifted"
  })
  cload_path_unshift /usr/lib
  t_is $CLOAD_PATH "/usr/lib:/lib"
})

t::group "cload_path_del" ({
  CLOAD_PATH="/usr/lib:/lib"
  cload_path_del /foo
  t_is $CLOAD_PATH "/usr/lib:/lib"
  cload_path_del /lib
  t_is $CLOAD_PATH "/usr/lib"
  cload_path_del /usr/lib
  t_ng $CLOAD_PATH
})

t::group "_prepare_to_load_clenv_libs" ({
  CLOAD_PATH=
  CLENV_ENVIRONMENT="foo"
  _prepare_to_load_clenv_libs
  t_is "$CLOAD_PATH" "$CLENV_ROOT/environments/foo/lib"
})

# vim:set ft=sh :
