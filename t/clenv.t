. shrc.d/clenv.shrc

clenv=${__clenv_base_dir}/bin/clenv

(
  t_substart "clenv init-env"
  (
    $clenv init-env test1 >/dev/null
    $clenv init-env test2 >/dev/null
  )
  t_is $? 0 "succeed to initialize test1, test2 env"
  test -d ${__clenv_base_dir}/environments/test1/bin
  t_is $? 0 "exists test1 bin"
  test -d ${__clenv_base_dir}/environments/test2/lib
  t_is $? 0 "exists test2 lib"
  t_subclose
)
t_subend "clenv init-env"
for i in 1 2; do
  rm -rf $__clenv_base_dir/environments/test$i
done

# setup to switch
__clenv_base_dir=tmp/clenv
for i in 1 2; do
  for dir in bin lib modules; do
    mkdir -p $__clenv_base_dir/environments/test$i/$dir
  done
done
cat <<EOLIB > $__clenv_base_dir/environments/test2/lib/foo.shrc
__test2_foo="TEST2_FOO"
EOLIB

(
  t_substart "clenv_switch"
  clenv_switch test1
  t_is $CLENV_ENVIRONMENT "test1" "switch to test1"
  _link=$(readlink ${__clenv_base_dir}/shims)
  t_is $_link "${__clenv_base_dir}/environments/test1/bin" "shims linked to test1/bin"
  t_subclose
)
t_subend "clenv_switch"

(
  t_substart "clenv_use"
  clenv_use test2
  t_is $CLENV_ENVIRONMENT "test2" "switch to test2"
  _link=$(readlink ${__clenv_base_dir}/shims)
  t_is $_link "${__clenv_base_dir}/environments/test2/bin" "shims linked to test2/bin"
  t_is $__test2_foo "TEST2_FOO" "library loaded"
  t_subclose
)
t_subend "clenv_use"

rm -rf $__clenv_base_dir

# vim:set ft=sh :