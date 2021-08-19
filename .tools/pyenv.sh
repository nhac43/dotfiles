#!/bin/sh

if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
fi

function install_pyenv() {
    if [ ! -d "$HOME/.pyenv" ]; then
        git clone https://github.com/yyuu/pyenv.git ~/.pyenv
        git clone git://github.com/yyuu/pyenv-update.git ~/.pyenv/plugins/pyenv-update
    else
        echo "Already pyenv is set up."
    fi
}
