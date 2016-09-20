export CLENV_ROOT=$(pwd)
export PATH="$(pwd)/shims:$(pwd)/bin:$PATH"
. shrc.d/clenv.shrc

# Prepare an environment
clenv create test-clam
clenv_use test-clam

T_SUB "Install and Uninstall a module" ((
  module="test-simple"
  clam install t/resource/test-clam-modules/simple
  t_is $? 0 "succeed to install simple module"
  clam list | grep $module &>/dev/null
  t_is $? 0 "check install ... OK"
  simple-cmd | grep . &>/dev/null
  t_is $? 0 "run installed command ... OK"
  clam uninstall $module
  t_is $? 0 "succeed to uninstall simple module"
  cnt=$(clam list | grep -c $module)
  t_is $cnt 0 "check uninstall ... OK"
))

# Destroy environment
rm -rf ${CLENV_ROOT}/environments/test-clam

# vim:set ft=sh :
