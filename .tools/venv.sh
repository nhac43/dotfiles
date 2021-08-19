#!/bin/sh

function vc() {
    if [ $# != 0 ]; then
        pyenv local $1
    fi
    python -m venv .venv
} 
function vca() {
    if [ $# != 0 ]; then
        pyenv local $1
    fi
    python -m venv .venv
    source .venv/bin/activate
} 
alias va='source .venv/bin/activate'
alias vd='deactivate'
