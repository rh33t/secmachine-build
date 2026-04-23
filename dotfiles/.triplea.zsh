# Environment
export HACKING_LAB="$HOME/work"

export PATH=$PATH:/sbin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HACKING_LAB/tools/built
export PATH=$PATH:$HACKING_LAB/tools/custom/

export MANPAGER='nvim +Man!'

# Tool Init
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cdd='cd $HACKING_LAB; clear;'
alias dl='cd ~/Downloads'

# System
alias l='ls -CF --color=auto'
alias ll='ls -alh --color=auto'
alias la='ls -A --color=auto'
alias v='nvim'
alias vim='nvim'
alias p='python3'
alias opx='xdg-open'
alias please='sudo'
alias _i='sudo -i'
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias stty-size='echo "stty rows $LINES cols $COLUMNS"'

# Clipboard
alias pbcopy='xsel --input --clipboard'
alias pbpaste='xsel --output --clipboard'

# Network
alias ssha='ssh -i $HACKING_LAB/configs/ssh/kali -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias sshu='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias sshi='ssh -i $HACKING_LAB/configs/ssh/kali'
alias ncl='nc -lnvp'
alias openports='ss -tlnp'

# Docker
alias dccall='docker stop $(docker ps -aq) > /dev/null && docker rm $(docker ps -aq) > /dev/null'
alias dccdi='docker rmi $(docker images -f "dangling=true" -q)'
alias dcit='docker run --rm -it -v /tmp:/tmp -v "$PWD":/pwn -w /pwn'

# Hacking / CTF
alias pysrv='python3 -m http.server'
alias phpd='php -S 0.0.0.0:8000 -ddisplay_errors=1 -dzend_extension=xdebug.so -dxdebug.remote_enable=1'
alias efs='file=$(fzf --reverse --preview="cat {}" --walker-skip=.git,vendor,node_modules -i) && [ -n "$file" ] && nvim "$file"'
bindkey -s '^k' 'efs\n'

# Encoding / Decoding
alias urldec='python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.argv[1]))"'
alias urlenc='python3 -c "import sys; from urllib.parse import quote; print(quote(sys.argv[1], safe=str()))"'

hex-encode() { echo "$@" | xxd -p; }
hex-decode() { echo "$@" | xxd -p -r; }
rot13()      { echo "$@" | tr 'A-Za-z' 'N-ZA-Mn-za-m'; }
b64e()       { echo -n "$@" | base64; }
b64d()       { echo -n "$@" | base64 -d; }
md5()        { echo -n "$@" | md5sum | cut -d' ' -f1; }
sha256()     { echo -n "$@" | sha256sum | cut -d' ' -f1; }

# Web Recon
alias osint-creds='f(){ xdg-open "https://cirt.net/passwords?criteria=$@"; unset -f f; }; f'
alias osint-port='f(){ xdg-open "https://www.speedguide.net/port.php?port=$@"; unset -f f; }; f'
alias osint-certspotter='f(){ curl -sS "https://api.certspotter.com/v1/issuances?domain=$1&include_subdomains=true&expand=dns_names&expand=issuer&expand=cert" | jq; unset -f f; }; f'
alias osint-vt='f(){ xdg-open "https://www.virustotal.com/gui/domain/$1"; unset -f f; }; f'
alias osint-crt='f(){ curl -sk "https://crt.sh/json?q=$1" | jq .; unset -f f; }; f'
alias osint-wayback='f(){ curl -sk "https://web.archive.org/cdx/search/cdx?fl=original&collapse=urlkey&url=*.$1"; unset -f f; }; f'
alias osint-leakix='f(){ curl -sk "https://leakix.net/api/graph/hostname/$1?v[]=hostname&v[]=ip&d=auto&l=auto" | jq | grep -ioP "hostname/[^\"]+" | cut -d/ -f2 | sort -uV; unset -f f; }; f'

# Functions
quickcommit() { git add -A && git commit -m "${1:-quick save in $(basename "$PWD") - $(date +%F_%H:%M:%S)}" && git push; }
mcd() { mkdir -p -- "$1" && cd -- "$1"; }
fcopy() { [ -f "$1" ] && pbcopy < "$1"; }
termbin() { [ -t 0 ] && [ -f "$1" ] && nc termbin.com 9999 < "$1" || nc termbin.com 9999; }

z() {
  local dir
  dir=$(
    zoxide query --list --score |
      fzf --height 60% --layout reverse --info inline \
          --nth 2.. --no-sort --query "$*" \
          --bind 'enter:become:echo {2..}'
  ) && cd "$dir"
}

fastmap() {
  local target=${1:?Usage: fastmap <target> [output_file]}
  local out=${2:-nmap-report.txt}
  local ports

  echo "[fastmap] discovering ports on $target..."
  ports=$(nmap -p- --min-rate=1000 -Pn -T4 "$target" \
    | awk '/^[0-9]/{split($1,a,"/"); printf a[1]","}' \
    | sed 's/,$//')

  if [[ -z "$ports" ]]; then
    echo "[fastmap] no ports found, host down?"
    return 1
  fi

  echo "[fastmap] ports: $ports"
  echo "[fastmap] running detailed scan..."
  nmap -p"$ports" -vv -Pn -sC -sV "$target" -oN "$out"
  echo "[fastmap] done! output saved to $out"
}
