# bash

version_compare() {
  local ver_a=$1
  local ver_b=$2
  local _result=${3:-version_compare_result}
  local _n_a _n_b _sorted

  split_string $ver_a '.' nums_a
  split_string $ver_b '.' nums_b

  local i=0
  local _ret=0
  while true; do
    _n_a=${nums_a[$i]:-}
    _n_b=${nums_b[$i]:-}
    if [[ -z $_n_a && -z $_n_b ]]; then
      break
    fi
    if [[ $_n_a = $_n_b ]]; then
      i=$((i + 1))
      continue
    fi
    _sorted=($(echo -e "${_n_a}\n${_n_b}" | sort -nr | sort -r))
    case ${_sorted[0]} in
      "$_n_a" )
        _ret=1
        ;;
      "$_n_b" )
        _ret=-1
        ;;
    esac
    break
  done

  unset nums_a
  unset nums_b

  eval "$_result=$_ret"
}

# vim:set ft=sh :
