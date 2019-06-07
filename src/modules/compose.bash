# ---
# Category: Util
# Since: 0.1.0
# Usage: l.compose <arg> [<fn>]...
# ---

l.compose() {
  local -a args=( "$1" )
  shift

  for f in "$@"; do
    args=( "$($f "${args[@]}")" )
  done
}