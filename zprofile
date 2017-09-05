# Path to your oh-my-zsh installation.
export ZSH=/Users/yuanlinfeng/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="gallois"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE = 'true'

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git autojump)

# User configuration
# autojump
# brew install autojump
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh
# zsh-completions
# brew install zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

export PATH="/usr/local/Homebrew/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/bin:/usr/sbin:/sbin:/usr/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:/usr/local/mysql/bin"

export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
#if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias cda="cd $HOME/Desktop/qdata-mgr/src"
alias cd1="cd $HOME/Desktop/cloud && gitstash.py release-5.0.1"
alias cd2="cd $HOME/Desktop/cloud && gitstash.py release-5.0.0"

alias cd0="cd $HOME/Desktop/qdatd-web && gitstash.py develop"
alias cdb="cd $HOME/Desktop/qdata-web"
alias cdc="cd $HOME/Desktop/dbpool/src"
alias cdd="cd $HOME/Desktop/cloud"
alias cde="cd $HOME/Work/webhook"
alias cdg="cd $HOME/Google\ Drive"
alias cdv1="cd $HOME/Google\ Drive/Docker/docker-k8s-lab/lab/docker/multi-node/vagrant"
alias cdv2="cd $HOME/Google\ Drive/Docker/docker-k8s-lab/lab/k8s/coreos-kubernetes/multi-node/vagrant"



alias shutdown="echo ignore shutdown"
alias reboot="echo ignore reboot"
alias npm install="npm install express --registry=https://registry.npm.taobao.org"
alias SSH="$HOME/bin/qssh"
alias DNS="sudo killall -HUP mDNSResponder" # clear dns
alias u="SSH ubuntu"
alias c="SSH centos"
alias z="SSH zs"


# vim mode
#bindkey -v
#export KEYTIMEOUT=1
#something() {
#zle backward-word
#}
#zle -N something
#function zle-line-init zle-keymap-select {
#VIM_PROMPT="%{$fg_bold[red]%} [% NORMAL]% %{$reset_color%}"
#RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $(git_custom_status)$EPS1"
#zle reset-prompt
#}
#zle -N zle-line-init
#zle -N zle-keymap-select

# settings
unsetopt share_history

# tmux
export TERM=xterm-256color

# golang
export GOBIN=/usr/local/Homebrew/bin/go
export GOPATH=/Users/linfeng/Work/Golang
export GOROOT=/usr/local/Homebrew/Cellar/go/1.8.3
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# rust
export PATH=/Users/linfeng/.cargo/bin:$PATH

# oracle
export ORACLE_HOME=/Users/linfeng/oracle/instantclient_11_2
export DYLD_LIBRARY_PATH=$ORACLE_HOME
export LD_LIBRARY_PATH=$ORACLE_HOME

alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

#java
export JAVA_HOME=$(/usr/libexec/java_home)

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export DISABLE_AUTO_TITLE="true"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# vmware start/stop
VM_ubuntu="/Users/yuanlinfeng/VirtualMachines/UbuntuServer.vmwarevm"
VM_windows="/Users/yuanlinfeng/VirtualMachines/WindowXP.vmwarevm"
VM_centos="/Users/yuanlinfeng/VirtualMachines/CentOS.vmwarevm"
VMRUN="/Applications/VMware\ Fusion.app/Contents/Library/vmrun"
alias start_ubuntu="$VMRUN -T fusion start $VM_ubuntu nogui"
alias stop_ubuntu="$VMRUN stop $VM_ubuntu"
alias start_windows="$VMRUN -T fusion start $VM_windows"
alias stop_windows="$VMRUN stop $VM_windows nogui"
alias start_centos="$VMRUN -T fusion start $VM_centos nogui"
alias stop_centos="$VMRUN stop $VM_centos"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/Library/TeX/Root/bin/x86_64-darwin:$PATH"

# anacondo
export PATH="$PATH:/Applications/anaconda3/bin"
alias start_notebook="source /Applications/anaconda3/bin/activate && jupyter notebook --notebook-dir=/Users/yuanlinfeng/Google\ Drive/Notebook; source deactivate"


# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
