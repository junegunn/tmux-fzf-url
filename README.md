tmux-fzf-url
============

Fork of [wfxr/tmux-fzf-url](https://github.com/wfxr/tmux-fzf-url).

Prerequisites
-------------

- [tmux][tmux]
    - Popup window is used if you have tmux 3.2 or above
- [fzf][fzf]
    - `fzf-tmux` should be on `$PATH`

[tmux]: https://github.com/tmux/tmux
[fzf]: https://github.com/junegunn/fzf

Installation
------------

### Using [TPM](https://github.com/tmux-plugins/tpm)

Add this line to your tmux config file, then hit `prefix + I`:

```sh
set -g @plugin 'junegunn/tmux-fzf-url'
```

Usage
-----

Press `PREFIX` + `u`.

Customization
-------------

```sh
# Bind-key (default: 'u')
set -g @fzf-url-bind 'u'

# fzf-tmux layout (default: '-p70%' on tmux 3.2, '-d' otherwise)
#   (-p requires tmux 3.2 or above, see `man fzf-tmux` for available options)
set -g @fzf-url-layout '-p70%'
```

[License](LICENSE.txt)
----------------------

```
The MIT License (MIT)

Copyright (c) 2021 Junegunn Choi
Copyright (c) 2018 Wenxuan Zhang
```
