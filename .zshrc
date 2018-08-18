source ~/antigen.zsh

antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load the theme.
antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship

# Tell Antigen that you're done.
antigen apply

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# added by Anaconda3 installer
export PATH="/home/zekun/anaconda3/bin:$PATH"
# export PATH="/home/zekun/anaconda3/envs/py36/bin:$PATH"

# TRAMP
if [[ "$TERM" == "dumb" ]]
then
	unsetopt zle
	unsetopt prompt_cr
	unsetopt prompt_subset
	unfunction precmd
	unfunction preexec
	PS1='$ '
fi

# haskell
export PATH="/home/zekun/.local/bin:$PATH"
export PATH="/home/zekun/.cabal/bin:$PATH"

# key repeat setting
xset r rate 250 60

~/dotfiles/remap.sh
