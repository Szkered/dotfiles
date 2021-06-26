source ~/antigen.zsh

antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle poetry

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

# # TRAMP
# if [[ "$TERM" == "dumb" ]]
# then
# 	unsetopt zle
# 	unsetopt prompt_cr
# 	unsetopt prompt_subset
# 	unfunction precmd
# 	unfunction preexec
# 	PS1='$ '
# fi

# haskell
export PATH="/home/zekun/.local/bin:$PATH"
export PATH="/home/zekun/.cabal/bin:$PATH"

# key repeat setting
# xset r rate 250 50
# ~/dotfiles/remap.sh


# source /home/zekun/rg/rgf

# RG_EXCLUDES=(build target node node_modules bower_components \
#                    '.idea' '.settings' '.git' '.svn' '.gradle' '*min.js' '*min.css' '*js.map' '*css.map')

# alias rG='noglob rgf -f ${=${(j: -f :)RG_EXCLUDES}}'
# alias rg='rG -i'

declare -a lastoutput

alias krc='kubectl delete configmap -n zekun neuflow-config;kubectl create configmap -n zekun neuflow-config --from-file=configs'
# alias krc='kubectl delete configmap -n zekun precog-config;kubectl create configmap -n zekun precog-config --from-file=precog/configs'
# alias kgp='kubectl get pods -n zekun -o custom-columns=:.'
alias kap="kubectl get pods --all-namespaces -owide | grep Running | egrep -v 'monitoring|kubeflow|kube-system|tensorboard|default|kube-master'"

# if [ /usr/bin/kubectl ]; then source <(kubectl completion zsh); fi
source <(kubectl completion zsh)

export PATH=/usr/local/cuda-10.2/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-10.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

function chpwd() {
    print -Pn "\e]51;A$(pwd)\e\\";
}


export LD_LIBRARY_PATH=/usr/lib/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export CUDA_HOME=/usr/local/cuda

[[ /usr/bin/kubectl ]] && source <(kubectl completion zsh)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/zekun/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/zekun/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/zekun/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/zekun/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


alias fd=fdfind

export PYTHONBREAKPOINT=ipdb.set_trace

export PATH="/home/zekun/.poetry/bin:$PATH"

export XLA_FLAGS="--xla_gpu_cuda_data_dir=/home/zekun/xla"

alias p4v="echo KavNp1QYF | openconnect --protocol=anyconnect --script-tun --script 'ocproxy -k 30 -L 1666:10.21.100.45:1666 8683:10.21.100.45:8683' -u ma.xiao --passwd-on-stdin sh.oneconnect.garenanow.com:6443"
alias remap="~/dotfiles/remap.sh; xset r rate 250 60"
