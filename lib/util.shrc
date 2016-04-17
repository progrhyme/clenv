# bash

abspath() {
  local _file=$1
  local _absdir=$(cd $(dirname $_file) && pwd)
  echo ${_absdir}/$(basename $_file)
}

split_string() {
  local _string=$1
  local _delim=${2:-}
  local result=${3:-split_array}
  local _v
  if [[ $_delim ]]; then
    _string=$(echo $_string | tr -s "${_delim}" ' ')
  fi
  eval "$result=($(echo $_string))"
}

# vim:set ft=sh :
