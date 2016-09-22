export CLENV_ROOT="$(pwd)"
export PATH="$(pwd)/shims:$(pwd)/bin:$PATH"

# clear
CLENV_ENVIRONMENT=

# backup if exists
if [[ -e "${CLENV_ROOT}/environment" ]]; then
  mv "${CLENV_ROOT}/environment" tmp/global-environment.bak
fi

clenv create "global-test" >/dev/null

t::group "Get global environment" ({
  t::group "With no environment set" ({
    t_error "clenv global" "Can't get environment"
  })

  t::group "With some environment" ({
    echo foo > "$CLENV_ROOT/environment"
    t_is "$(clenv global)" "foo (set by $CLENV_ROOT/environment)" "Can get the environment"
    rm -f ${CLENV_ROOT}/environment
  })
})

t::group "Set global environment" ({
  t::group "When target environment doesn't exist" ({
    t_error "clenv global no-such-env" "Can't set environment"
  })
  t::group "When target environment exists" ({
    t_success "clenv global global-test" "Can set environment"
    t_is "$(clenv global)" "global-test (set by $CLENV_ROOT/environment)" "Can get the environment"
    rm -f ${CLENV_ROOT}/environment
  })
})

# restore
if [[ -e tmp/global-environment.bak ]]; then
  mv tmp/global-environment.bak "${CLENV_ROOT}/environment"
fi

rm -rf ${CLENV_ROOT}/environments/global-test

# vim:set ft=sh :
