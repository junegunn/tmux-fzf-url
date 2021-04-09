#!/usr/bin/env bash
#===============================================================================
#   Author: Wenxuan
#    Email: wenxuangm@gmail.com
#  Created: 2018-04-06 09:30
#===============================================================================
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

conf() {
  local value
  value=$(tmux show -gqv "$1")
  [ -n "$value" ] && echo "$value" || echo "$2"
}

key="$(conf @fzf-url-bind u)"

tmux_version=$(tmux -V | sed 's/[^0-9]*//' | awk -F. '{ printf("%d%03d\n", $1, $2); }')
(( tmux_version >= 3002 )) &&
  default_layout=-p70% ||
  default_layout=-d

layout=$(conf @fzf-url-layout "$default_layout")
tmux bind-key "$key" run -b "$SCRIPT_DIR/fzf-url.rb $layout";
