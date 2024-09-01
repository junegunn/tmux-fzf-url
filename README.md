tmux-fzf-url
============

Open URLs in the current pane with fzf.

Prerequisites
-------------

- [tmux][tmux] 3.3+ for popup support
- [fzf][fzf] 0.53.0+ for `--tmux` option

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
```

Acknowledgement
---------------

This project is a fork of
[wfxr/tmux-fzf-url](https://github.com/wfxr/tmux-fzf-url). However, most of
the code was completely rewritten.

[License](LICENSE.txt)
----------------------

```
The MIT License (MIT)

Copyright (c) 2021 Junegunn Choi
Copyright (c) 2018 Wenxuan Zhang
```
