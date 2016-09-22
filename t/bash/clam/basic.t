export CLENV_ROOT="$(pwd)"
export PATH="$(pwd)/shims:$(pwd)/bin:$PATH"

# backup if exists
local_envfile="$(pwd)/.clenv-environment"
if [[ -e "$local_envfile" ]]; then
  mv "$local_envfile" "tmp/local-environment.bak"
fi

# Prepare an environment
clenv create test-clam
clenv local test-clam

t::group "Install and Uninstall a module" ({
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
})

# Destroy environment
rm -f .clenv-environment
rm -rf ${CLENV_ROOT}/environments/test-clam

# restore
if [[ -e tmp/local-environment.bak ]]; then
  mv tmp/local-environment.bak "$local_envfile"
fi

# vim:set ft=sh :
