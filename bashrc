# bashrc

if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
function setpyenv() {
    if [ ! -d "$HOME/.pyenv" ]; then
        git clone https://github.com/yyuu/pyenv.git ~/.pyenv
        git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
        git clone git://github.com/yyuu/pyenv-update.git ~/.pyenv/plugins/pyenv-update
    else
        echo "Already pyenv is set up."
    fi
}

if [ $SHLVL = 1 ]; then
  tmux
fi
