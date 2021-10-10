#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias t2mode="ffmpeg -v debug -f video4linux2 -i /dev/video0 -vf scale=iw/4:ih/4,scale=8*iw:8*ih:flags=neighbor -s 256x144 -r 2 -f video4linux2 /dev/video2"
alias normal_mode="ffmpeg -v debug -f video4linux2 -i /dev/video0 -s 256x144 -r 2 -f video4linux2 /dev/video2"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
