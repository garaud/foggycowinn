# -*- mode: sh -*-

function _jh-prev-result
{
    # Re-launch last command and save the result. It's possible to use it when
    # you have a list of files printed out by a 'find' and you want to open one
    # of these files.
    # From: "Tip of the day: previous command output"
    # http://www.zsh.org/mla/users/2004/msg00966.html
    hstring=$(eval `fc -l -n -1`)
    set -A hlist ${(@s/
/)hstring}
    compadd - ${hlist}
}

zle -C jh-prev-comp menu-complete _jh-prev-result
bindkey '\ee' jh-prev-comp # Alt-e
