if test -e ~/.secrets
  source ~/.secrets
end

set -gx EDITOR nvim
set -gx NODE_OPTIONS --max_old_space_size=4096
set -gx NODE_OPTIONS --openssl-legacy-provider $NODE_OPTIONS

eval (/opt/homebrew/bin/brew shellenv)

# Aliases

alias rc="$EDITOR ~/.config/fish/config.fish"
alias tmuxdev="tmux split-window -h && tmux split-window && tmux resize-pane -R 30 && tmux select-pane -L && tmux rename-window DEVELOPMENT"
alias tmuxops="tmux split-window -h && tmux select-pane -L && tmux rename-window OPS"
alias notes="$EDITOR ~/NOTES.md"
alias rm="echo You should probably use 'trash' instead. To override, use full bin path: '/bin/rm'."

# Extended Config Sources

source ~/.config/fish/flightlogger.fish
