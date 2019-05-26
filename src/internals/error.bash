# Usage: error msg1 [msg2 ... msgN]
# Print logs to stdrr.
# If LOBASH_WARN_OUTPUT set, logs pipe to $LOBASH_WARN_OUTPUT instead of stdrr
#
# It will not print logs to stdout in below scenario:
#
#   foo() { error hello; }
#   bar=$(foo) # => Not see any log in shell
#
# LOBASH_WARN_OUTPUT can resolve the problem.
#
#   LOBASH_WARN_OUTPUT=/tmp/log
#   foo() { warn2 hello; }
#   bar=$(foo) # => Still not see any log in shell, but logs records in file /tmp/log
error() {
  if [[ -z $LOBASH_WARN_OUTPUT ]]; then
    echo "[error:lobash] $*" >&2
  else
    echo "[error:lobash] $*" >> "$LOBASH_WARN_OUTPUT"
  fi
}
