## Installing tmux from source (non root)

### Libevent Setup
```
$ wget https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
$ tar xvf libevent-2.0.22-stable.tar.gz
$ cd libevent-2.0.22-stable
$ ./configure --prefix=$HOME
$ make # use make -j 8 to speed it up if your machine is capable
$ make install
```

### Tmux Setup
```
$ wget https://github.com/tmux/tmux/releases/download/2.9/tmux-2.9.tar.gz
$ tar xvf tmux-2.9.tar.gz
$ ./configure --prefix=$HOME CFLAGS="-I$HOME/include" LDFLAGS="-L$HOME/lib"
$ make
$ make install
```

### $PATH Setup
tmux will be installed in $HOME/bin.
```
$ export PATH=$HOME/bin:$PATH
```

### Notes
- Currently, tmux2.5+ cannot display big images. Use tmux <= 2.4.
- There are modified versions with better tmux support by [Eric Dobson](https://gitlab.com/gnachman/iterm2/issues/3898#note_14097715) and by [@krtx](https://gist.github.com/krtx/533d33d6cc49ecbbb8fab0ae871059ec)

Raw modified version of imgcat are in `/bin`.




### Reference

- [http://jhshi.me/2016/07/08/installing-tmux-from-source-non-root/index.html#.XbBQX5P7RQI](http://jhshi.me/2016/07/08/installing-tmux-from-source-non-root/index.html#.XbBQX5P7RQI)
- https://pypi.org/project/imgcat/