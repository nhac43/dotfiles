#!/bin/bash

function ivim(){
    tmux split-window -v
    tmux resize-pane -D 15
    tmux split-window -h
    tmux resize-pane -R 75
    tmux select-pane -t 0
    tmux send -t 2 'tig status' Enter
    vim
}
