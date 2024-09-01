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

tmux bind-key "$key" run -b "$SCRIPT_DIR/fzf-url.rb";
