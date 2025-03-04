# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	docker
	golang
	kubectl
	minikube
	kind
	kubebuilder
	helm
	pip
	aws
	oc
)

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export GOPATH="$HOME/go"
PATH="$PATH:$GOPATH/bin:$HOME/.local/bin"

alias vim=nvim
alias vagrant-up="NETNEXT=1 make --environment-overrides vagrant-up"
alias vagrant-ssh="NETNEXT=1 make --environment-overrides vagrant-ssh"
alias vagrant-halt="NETNEXT=1 make --environment-overrides vagrant-halt"
alias vagrant-destroy="NETNEXT=1 make --environment-overrides vagrant-destroy"
alias n="neofetch"
alias ra="ranger"
alias glow="glow --pager"

export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"
export FZF_DEFAULT_OPTS="--bind 'ctrl-f':preview-down,'ctrl-b':preview-up,'ctrl-space':toggle-preview-wrap --cycle"

bindkey "\ep" up-line-or-beginning-search
bindkey "\en" down-line-or-beginning-search
bindkey -s "\et" 'tmux^M'

# for unbinding ctrl+w
#stty werase undef
#bindkey -r "\C-w"
#bindkey "\e\C-w" backward-kill-word

function make-vagrant () {
	#if [[ "$PWD" =~ "$HOME/dev/KubeArmor" ]]; then
	#	echo "in dev"
	#	make vagrant-${1}
	#else
	#	echo "not in dev"
	#	NETNEXT=1 make --environment-overrides vagrant-${1}
	#fi
	echo "not in dev"
	NETNEXT=1 make --environment-overrides vagrant-${1}
}

function drmc() {
	if [[ -z ${1} ]]; then
		echo "need an argument"
		return 1
	fi
	docker stop $(docker ps -a | grep "${1}" | sed 's/\s/:/g' | tr -s ':' | cut -d ':' -f1)
	docker rm --force $(docker ps -a | grep "${1}" | sed 's/\s/:/g' | tr -s ':' | cut -d ':' -f1)
}

function drmi() {
	if [[ -z ${1} ]]; then
		echo "need an argument"
		return 1
	fi
	docker rmi --force $(docker images | grep "${1}" | sed 's/\s/:/g' | tr -s ':' | cut -d ':' -f3)
}

function idt-login() {
	wl-copy -o $(cat ~/accuknox/secrets/idt-raw)
	sshpass -f $HOME/accuknox/secrets/idt-raw ssh -p 666 ziggy@dlz81euo2zj.d.firewalla.org -t "sudo su -l -c 'tmux a'"
}

function idt-ports() {
	sudo sshpass -f ~/accuknox/secrets/idt-raw ssh -p 666 ziggy@dlz81euo2zj.d.firewalla.org -T -L localhost:80:localhost:80 -L localhost:8034:localhost:8034 -L localhost:8888:localhost:8888 -L localhost:8080:localhost:8080 -L localhost:5900:localhost:5900
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(direnv hook zsh)"

# managing dotfiles
alias dm='git --git-dir=$HOME/.config/dotfiles.git --work-tree=$HOME'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/rudraksh/builds/google-cloud-sdk/path.zsh.inc' ]; then . '/home/rudraksh/builds/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/rudraksh/builds/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/rudraksh/builds/google-cloud-sdk/completion.zsh.inc'; fi

export CERN_HOME="$HOME/cern"
