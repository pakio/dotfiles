# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zplug "mrowa44/emojify", as:command

zplug "b4b4r07/enhancd"
zplug "junegunn/fzf-bin", as:command, from:gh-r
zplug "peco/peco", as:command, from:gh-r
zplug "romkatv/powerlevel10k", as:theme, depth:1

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

HISTSIZE=10000
SAVEHIST=10000

zplug load


export PATH=$HOME/work/bin:$PATH

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
export PATH="/opt/homebrew/opt/php@8.0/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.0/sbin:$PATH"
export GOPATH="/Users/pakio/go"
export PATH="$GOPATH/bin:$PATH"


## aliases
alias ls="ls -GFalsh"
alias gls="gls --color"
alias k="kubectl"
alias x="kubectx"
alias z="kubens"
alias s="stern"

## 大文字小文字を区別せずに自動補完
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## gitステータスの自動更新
function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## kubens cache
function kns() {
  cat "$HOME/.local/share/kubectx-cache/$(kubectx -c)" | fzf | xargs kubens
}

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

eval "$(pyenv init -)"
eval "$(jenv init -)"

# tmuxの自動起動
count=`ps aux | grep tmux | grep -v grep | wc -l`
if test $count -eq 0; then
    echo `tmux`
elif test $count -eq 1; then
    echo `tmux a`
fi
