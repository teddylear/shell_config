#!/usr/bin/bash

SESSIONNAME="personal"
tmux new-session -s $SESSIONNAME -c "$HOME/Documents/journal" -d
tmux rename-window -t 0 "JOURNAL"

tmux new-window -c "$HOME/shell_config" -n "SHELL_CONFIG" -t $SESSIONNAME
tmux move-window -s 1 -t 9

tmux new-window -c "$HOME/code/ansible" -n "ANSIBLE" -t $SESSIONNAME
tmux move-window -s 1 -t 8

tmux attach -t $SESSIONNAME
