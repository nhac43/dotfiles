#!/bin/sh

function install_fzf() {
    if [ ! -d "$HOME/.fzf" ]; then
        git clone https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    else
        echo "Already fzf is set up."
    fi
}

