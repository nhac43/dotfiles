#!/bin/bash

function ivim(){
    tmux split-window -v
    tmux resize-pane -D 15
    tmux select-pane -t 0
    tmux new-window -n tig
    tmux select-window -t 0
    tmux send -t tig.0 'tig status' Enter
    vim
}
