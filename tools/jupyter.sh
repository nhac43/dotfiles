#!/bin/sh

function js() {
    if [ $# = 0 ]; then
        echo Usage: 
        echo "\$js [notebook].ipynb"
        echo Jupytext sync is failed.
        return
    fi
    if [ -f ${1%.*}.py ]; then
        jupytext --sync $1
    else
        jupytext --set-formats ipynb,py:percent $1
    fi
} 

alias jc='python ${DOTFILES}/jupyter/create-notebook.py'

function jcs() {
    jc $1
    js ${1}.ipynb
}
