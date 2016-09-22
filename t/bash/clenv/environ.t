export CLENV_ROOT="$(pwd)"
export PATH="$(pwd)/shims:$(pwd)/bin:$PATH"

# clear
CLENV_ENVIRONMENT=

# backup if exists
if [[ -e "${CLENV_ROOT}/environment" ]]; then
  mv "${CLENV_ROOT}/environment" tmp/global-environment.bak
fi

clenv create "environ-test1" >/dev/null
clenv create "environ-test2" >/dev/null

t::group 'Without CLENV_ENVIRONMENT and any environment file' ({
  t_error "clenv environ" "Can't get environment"
})

t::group 'With global environment file' ({
  echo environ-test1 > ${CLENV_ROOT}/environment
  t_is "$(clenv environ)" "environ-test1 (set by ${CLENV_ROOT}/environment)"
  rm -f ${CLENV_ROOT}/environment
})

t::group 'With global & local environment file' ({
  echo environ-test1 > ${CLENV_ROOT}/environment
  mkdir -p tmp/x
  echo environ-test2 > tmp/.clenv-environment
  cd tmp
  tmpdir=$(pwd)
  t_is "$(clenv environ)" "environ-test2 (set by ${tmpdir}/.clenv-environment)"
  cd x
  t_is "$(clenv environ)" "environ-test2 (set by ${tmpdir}/.clenv-environment)"
  cd ../..
  t_is "$(clenv environ)" "environ-test1 (set by ${CLENV_ROOT}/environment)"
  rm -rf tmp/x
  rm -f tmp/.clenv-environment ${CLENV_ROOT}/environment
})

t::group 'With CLENV_ENVIRONMENT' ({
  export CLENV_ENVIRONMENT=environ-test1
  t_is "$(clenv environ)" "environ-test1 (set by CLENV_ENVIRONMENT)"
})

t::group 'With environment not exist' ({
  export CLENV_ENVIRONMENT=environ-test3
  t_error "clenv environ"
  CLENV_ENVIRONMENT=
  echo environ-test4 > ${CLENV_ROOT}/environment
  t_error "clenv environ"
  rm -f ${CLENV_ROOT}/environment
})

# restore
if [[ -e tmp/global-environment.bak ]]; then
  mv tmp/global-environment.bak "${CLENV_ROOT}/environment"
fi

rm -rf ${CLENV_ROOT}/environments/environ-test*

# vim:set ft=sh :
