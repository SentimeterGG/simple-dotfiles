# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/.npm-global/bin:$HOME/fvm/default/bin:$HOME/.cargo/bin:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# export ANDROID_HOME="/opt/android-sdk/"
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
# ENABLE_CORRECTION="true"

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
#plugins=()

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Enable autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Enable fast syntax highlighting
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Completion
autoload -Uz compinit
compinit

# Clipboard yank function
function yank-to-clipboard() {
  # Yank the current selection to internal Zsh buffer
  zle vi-yank

  # Get current buffer contents (what was yanked)
  local yanked="$CUTBUFFER"

  # Send to clipboard based on OS/tool
  if command -v pbcopy >/dev/null; then
    print -rn -- "$yanked" | pbcopy
  elif command -v xclip >/dev/null; then
    print -rn -- "$yanked" | xclip -selection clipboard
  elif command -v xsel >/dev/null; then
    print -rn -- "$yanked" | xsel --clipboard --input
  elif command -v wl-copy >/dev/null; then
    print -rn -- "$yanked" | wl-copy
  else
    print "No clipboard utility found." >&2
  fi
}
zle -N yank-to-clipboard

# Cursor shapes
cursor_block="\e[2 q"   # steady block
cursor_line="\e[6 q"    # steady line

function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne $cursor_block   # normal mode → block
  else
    echo -ne $cursor_line    # insert mode → line
  fi
}
zle -N zle-keymap-select

# Ensure cursor is correct at startup
function zle-line-init {
  zle -K viins
  echo -ne $cursor_line
}
zle -N zle-line-init

# Prompt config
source ~/.powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Vim mode and bindings
bindkey -v
bindkey -M vicmd 'y' yank-to-clipboard

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

tmr(){
  timer "$@" ~/Music/.alarm.sh
}

7zx() {
  if [[ -z "$1" ]]; then
    echo "Usage: 7zx <archive>"
    return 1
  fi

  local file="$1"
  local name="${file:r}"   # remove extension in zsh

  7z x "$file" -o"$name"
}
KEYTIMEOUT=15  # in 10ms units, so 15 = 150ms

bindkey -M viins 'jk' vi-cmd-mode
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
export EDITOR=nvim
alias sudo="sudo -E"
alias conf-dwm="cd ~/.config/dwm"
alias conf-dmenu="cd ~/.config/dmenu"
alias y="yay -S --noconfirm"
alias yu="yay -Syu --noconfirm"
alias ys="yay -Ss"
alias yi="yay -Si"
alias yr="/home/sentimers/.config/linux-scripts/purgepkg.sh"
alias waydroid-start="waydroid session stop && sudo systemctl restart waydroid-container.service && waydroid session start & waydroid show-full-ui & disown"
alias xampp="sudo xampp"
alias hyprpicker='hyprshade off && sleep 1 && hyprpicker -a && hyprshade on vibrance'
alias ls='LS_COLORS= eza --icons=always --hyperlink -stype --color=always'
alias yt='mov-cli -s youtube'
alias neofetch='fastfetch'
alias ff='fastfetch'
alias rescan='nmcli device wifi rescan'
alias clipwin='scrot -u -d 2 - | xclip -selection clipboard -t image/png'
export QTWEBENGINE_DISABLE_SANDBOX=1

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
