export CLENV_ROOT=.
export PATH="$(pwd)/shims:$(pwd)/bin:$PATH"
. shrc.d/clenv.shrc

clenv create "use-test1" >/dev/null
clenv create "use-test2" >/dev/null

export CLENV_ENVIRONMENT="use-test2"

t::group "clenv_use" ({
  clenv_use "use-test1"
  t_is $CLENV_ENVIRONMENT "use-test1" "switch to use-test1"
  clenv_use "use-test2"
  t_is $CLENV_ENVIRONMENT "use-test2" "switch to use-test2"

})

for i in 1 2; do
  rm -rf ${CLENV_ROOT}/environments/use-test$i
done

# vim:set ft=sh :
