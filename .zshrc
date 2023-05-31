source ~/antigen.zsh
antigen init ~/.antigenrc

# Add paths
export PATH="$PATH:$HOME/.config/emacs/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"

# quick command
alias remap="~/dotfiles/remap.sh; xset r rate 250 60"
alias vpn="~/dotfiles/vpn.sh"
alias pkg_pull="~/dotfiles/pacman-sync/pkg_pull.sh"
alias pkg_push="~/dotfiles/pacman-sync/pkg_push.sh"

# python ipdb
export PYTHONBREAKPOINT=ipdb.set_trace

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

if
    ! command -v brew &
    >/dev/null
then # not mac
    source /usr/share/nvm/init-nvm.sh
else # is mac
    export PATH="$PATH:/Applications/Emacs.app/Contents/MacOS/bin"
fi

export BROWSER=eaf-browser

# zsh history
ZSH_HISTORY_FILE_NAME=".zsh_history"
ZSH_HISTORY_FILE="${HOME}/${ZSH_HISTORY_FILE_NAME}"
ZSH_HISTORY_PROJ="${HOME}/.zsh_history_proj"
ZSH_HISTORY_FILE_ENC_NAME="zsh_history"
ZSH_HISTORY_FILE_ENC="${ZSH_HISTORY_PROJ}/${ZSH_HISTORY_FILE_ENC_NAME}"
ZSH_HISTORY_COMMIT_MSG="latest $(date)"
