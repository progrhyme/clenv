export CLENV_ROOT=.
. shrc.d/clenv.shrc

clenv=${__clenv_base_dir}/bin/clenv

t::group "clenv init-env" ({
  (
    $clenv create test1 >/dev/null
    $clenv create test2 >/dev/null
  )
  t_is $? 0 "succeed to initialize test1, test2 env"
  test -d ${__clenv_base_dir}/environments/test1/bin
  t_is $? 0 "exists test1 bin"
  test -d ${__clenv_base_dir}/environments/test2/lib
  t_is $? 0 "exists test2 lib"
})
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

t::group "clenv_use" ({
  clenv_use test2
  t_is $CLENV_ENVIRONMENT "test2" "switch to test2"
})

rm -rf $__clenv_base_dir

# vim:set ft=sh :
