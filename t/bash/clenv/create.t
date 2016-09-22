export CLENV_ROOT="$(pwd)"
export PATH="$(pwd)/shims:$(pwd)/bin:$PATH"

t::group "clenv create" ({
  (
    clenv create create-test1 >/dev/null
    clenv create create-test2 >/dev/null
  )
  t_is $? 0 "succeed to initialize create-test1, create-test2 env"
  test -d ${CLENV_ROOT}/environments/create-test1/bin
  t_is $? 0 "exists create-test1 bin"
  test -d ${CLENV_ROOT}/environments/create-test2/lib
  t_is $? 0 "exists create-test2 lib"
})

rm -rf ${CLENV_ROOT}/environments/create-test*

# vim:set ft=sh :
