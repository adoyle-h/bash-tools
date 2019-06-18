# ---
# Category: Console
# Since: 0.1.0
# Usage: l.echo_array <array_name>
# Description: print each values of array with newline.
# ---

l.echo_array() {
  local -n l_echo_array_arg1=$1
  printf '%s\n' "${l_echo_array_arg1[@]}"
}