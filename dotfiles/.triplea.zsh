# important env 
export HACKING_LAB="$HOME/work"

# variables
export PATH=$PATH:/sbin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HACKING_LAB/tools/built
export PATH=$PATH:$HACKING_LAB/tools/custom/
export MANPAGER='nvim +Man!'

# pyenv configuration
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# zoxide
eval "$(zoxide init zsh)"

# aliases
alias gdb='gdb -q'
alias v='nvim'
alias vim='nvim'
alias p='python3'
alias opx='xdg-open'
alias l='ls -CF --color=auto'
alias ll='ls -alh --color=auto'
alias la='ls -A --color=auto'
alias pbcopy='xsel --input --clipboard'
alias pbpaste='xsel --output --clipboard'
alias cdd='cd $HACKING_LAB; clear;'
alias ssha='ssh -i $HACKING_LAB/configs/ssh/triplea -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias efs='file=$(fzf --reverse --preview="cat {}" --walker-skip=.git,vendor,node_modules -i) && [ -n "$file" ] && nvim "$file"'
alias pysrv='python3 -m http.server'
alias phpd='php -S 0.0.0.0:8000 -ddisplay_errors=1 -dzend_extension=xdebug.so -dxdebug.remote_enable=1'
alias dccall='docker stop $(docker ps -aq) > /dev/null && docker rm $(docker ps -aq) > /dev/null'
alias dccdi='docker rmi $(docker images -f "dangling=true" -q)'
alias 33h='ssh -i ~/work/configs/ssh/triplea'

# custom functions
quickcommit() {
  msg=${1:-"quick save in $(basename "$PWD") - $(date +%F_%H:%M:%S)"}
  git add -A && git commit -m "$msg" && git push
}

mcd() {
  mkdir -p "$1" && cd "$1"
}

fcopy() {
  if [ -f "$1" ]; then
    cat $1 | pbcopy
  fi
}

z() {
  local dir=$(
    zoxide query --list --score |
      fzf --height 60% --layout reverse --info inline \
      --nth 2.. --no-sort --query "$*" \
      --bind 'enter:become:echo {2..}'
    ) && cd "$dir"
  }

# manage box and ctf labs
lab() {
  local mode="$1"
  local script_name="training-tool.py"
  local temp_file

  case "$mode" in
    "ctf") temp_file="/tmp/challenger_path" ;;
    "box") temp_file="/tmp/box_path" ;;
    *) echo "Usage: lab {ctf|box}"; return 1 ;;
  esac

  python3 ~/.bin/hacking/$script_name $mode && [ -f "$temp_file" ] && cd "$(cat $temp_file)" && echo "[✓] Ready: $(pwd)"
}

fastmap() {
  local target=${1:?Usage: fastmap <target> [output_file] [options]}
  local out=${2:-nmap-${target//[.:]/-}-$(date +%s).txt}
  local opts="${3:--sC -sV}"
  
  command -v nmap &>/dev/null || { echo "nmap not found!" >&2; return 1; }
  
  echo "[+] Fast scanning $target..."
  local ports=$(nmap -p- --min-rate=5000 -T5 -Pn -n --open "$target" 2>/dev/null \
    | awk '/^[0-9]/{gsub("/.*","",$1); p=p","$1} END{sub(/^,/,"",p); print p}')
  
  [[ -z "$ports" ]] && { echo "[-] No open ports found" >&2; return 1; }
  
  echo "[+] Open ports: $ports"
  echo "[+] Deep scanning..."
  nmap -p"$ports" -A -T4 -Pn -n --open $opts "$target" -oN "$out" \
    && echo "[+] Results: $out"
}