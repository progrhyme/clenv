# bash

clamdb_init() {
  local base=${1:-"${CLENV_ROOT}/environments/${CLENV_ENVIRONMENT}"}
  local _absdir=$(cd ${base} && pwd)
  __clamdb_path=${base}/Clamdb.txt
  touch $__clamdb_path
}

clamdb_find() {
  local module=$1
  awk "\$1 == \"$module\"" $__clamdb_path
}

clamdb_add() {
  local module=$1
  local version=$2
  echo -e "$module\t$version" >> $__clamdb_path
}

clamdb_remove() {
  local module=$1
  local _tmpfile=${__clamdb_path}.tmp
  awk "\$1 != \"$module\"" $__clamdb_path > $_tmpfile
  mv $_tmpfile $__clamdb_path
}

clamdb_list() {
  cat $__clamdb_path
}

# vim:set ft=sh :
