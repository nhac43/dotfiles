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

function jc() {
    if [ $# = 0 ]; then
        echo Usage: 
        echo "\$jc [notebook name]"
        echo Jupytext create is failed.
        return
    fi
    python ${DOTFILES}/jupyter/create-notebook.py $1
    js $1.ipynb
} 
