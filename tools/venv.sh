#!/bin/sh

function vc() {
    if [ $# != 0 ]; then
        pyenv local $1
    fi
    python -m venv .venv
    source .venv/bin/activate
} 
function va(){
    path_activate='.venv/bin/activate'
    if [ $# != 0 ]; then
        path_activate=$1/$path_activate
    fi
    source $path_activate
}
alias vd='deactivate'
