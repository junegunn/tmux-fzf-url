tmux-fzf-url
============

Search the current tmux pane for URLs, use fzf to select one, and either
open it or copy it to the system clipboard.

> [!TIP]
> [tmux-fzf-complete][complete] does this as well, and also finds hyperlinks
> and URLs broken across lines. Set `@fzf-complete-url-bind` to `u` to open
> URLs with <kbd>PREFIX</kbd><kbd>u</kbd>, as this plugin does.

[complete]: https://github.com/junegunn/tmux-fzf-complete

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

### Manually

All you need to do is associate a tmux keybinding to run the Ruby
script. Add something like this to your `.tmux.conf` configuration file:

```
bind-key u run -b "/path/to/fzf-url.rb";
```

If you use [byobu](https://www.byobu.org/), you can put the script in
your byobu configuration directory and use
`$BYOBU_CONFIG_DIR/fzf-url.rb`.

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
