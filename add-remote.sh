#!/bin/sh
# gets the url for the given fork
__addremote_url() {
  # shellcheck disable=SC2039
  local fork remote current
  fork="$1"
  if ! git config --get remote.origin.url > /dev/null 2>&1; then
    echo "A remote called 'origin' doesn't exist. Aborting." >&2
    return 1
  fi
  remote="$(git ls-remote --get-url origin)"
  current="$(echo "$remote" | sed -e 's/.*github\.com.//' -e 's/\/.*//')"
  echo "$remote" | sed -e "s/$current/$fork/"
}

# adds a remote
# shellcheck disable=SC2039
add-remote() {
  # shellcheck disable=SC2039
  local fork="$1" name="$2" url
  test -z "$name" && name="$fork"
  url="$(__addremote_url "$fork")" || return 1
  git remote add "$name" "$url"
}

# adds an upstream remote
# shellcheck disable=SC2039
add-upstream() {
  add-remote "$1" "upstream"
}
