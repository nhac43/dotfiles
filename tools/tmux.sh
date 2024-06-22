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

function send_cd_to_vim() {
    if [ "$1" = "." ]; then
        target_path=${PWD}
    else
        target_path=$(search_cd_history)
    fi
    if [ ! -e "$target_path" ]; then
        return
    fi
    tmux send-key -t 0 ":cd ${target_path}" C-m
}

# send a text to pane 0
function send_to_pane() {
    while IFS= read -r line; do
        tmux send-key -t 0 "$line"
    done
}
