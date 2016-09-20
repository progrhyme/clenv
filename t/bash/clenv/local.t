export CLENV_ROOT="$(pwd)"
export PATH="$(pwd)/shims:$(pwd)/bin:$PATH"
. shrc.d/clenv.shrc

# clear
CLENV_ENVIRONMENT=

clenv create "local-test" >/dev/null
mkdir -p tmp/loc

t::group "Get local environment" ({
  cd tmp/loc
  t::group "With no environment set" ({
    t_error "clenv local" "Can't get environment"
  })

  t::group "With some environment" ({
    echo foo > .clenv-environment
    t_is "$(clenv local)" "foo (set by $(pwd)/.clenv-environment)" "Can get the environment"
    rm -f .clenv-environment
  })
})

t::group "Set local environment" ({
  cd tmp/loc
  t::group "When target environment doesn't exist" ({
    t_error "clenv local no-such-env" "Can't set environment"
  })
  t::group "When target environment exists" ({
    t_success "clenv local local-test" "Can set environment"
    t_is "$(clenv local)" "local-test (set by $(pwd)/.clenv-environment)" "Can get the environment"
    rm -f .clenv-environment
  })
})

rm -rf tmp/loc
rm -rf ${CLENV_ROOT}/environments/local-test

# vim:set ft=sh :
