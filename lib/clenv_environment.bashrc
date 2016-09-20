# bash

_clenv_local_environ_file() {
  local root="$1"
  while ! [[ "$root" =~ ^//[^/]*$ ]]; do
    if [ -e "${root}/.clenv-environment" ]; then
      echo "${root}/.clenv-environment"
      return 0
    fi
    [ -n "$root" ] || break
    root="${root%/*}"
  done
  return 1
}

clenv_environ_file() {
  local target_dir="${1:-}"
  if [[ -n "${target_dir}" ]]; then
    _clenv_local_environ_file "${target_dir}"
  elif _clenv_local_environ_file "${CLENV_DIR:-}"; then
    return
  elif [[ "${CLENV_DIR:-}" != "$PWD" ]] && _clenv_local_environ_file "$PWD"; then
    return
  else
    echo "${CLENV_ROOT}/environment"
  fi
}

clenv_environ() {
  local file="$1"
  [[ -e "$file" ]] || return 1

  # Read the first non-whitespace word from the specified environment file.
  # Be careful not to load it whole in case there's something crazy in it.
  IFS="${IFS}"$'\r'
  local words=( $(cut -b 1-1024 "$file") )
  local env="${words[0]}"

  [[ -n "$env" ]] && echo "$env"
  return
}
