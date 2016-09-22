# bash

prepare_clenv_for_cload() {
  [[ -z "${CLENV_ROOT:-}" ]] && return
  PATH="${CLENV_ROOT}/bin:$PATH"

  local _env=${CLENV_ENVIRONMENT:-$(clenv environ 2>/dev/null || true)}
  [[ -z $_env ]] && return
  cload_path_push "${CLENV_ROOT}/environments/${_env}/lib"
}
