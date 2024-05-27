if test -e ~/.secrets
  source ~/.secrets
end

set -gx EDITOR nvim

# Aliases

alias rc="$EDITOR ~/.config/fish/config.fish"
alias tmuxdev="tmux split-window -h && tmux split-window && tmux resize-pane -R 30 && tmux select-pane -L && tmux rename-window DEVELOPMENT"
alias tmuxops="tmux split-window -h && tmux select-pane -L && tmux rename-window OPS"
alias notes="$EDITOR ~/NOTES.md"
alias rails="bundle exec rails"
# alias rm="echo You should probably use 'trash' instead. To override, use full bin path: '/bin/rm'."

# Extended Config Sources

# source ~/.config/fish/flightlogger.fish

# Nix shell status in prompt.
function postexec_nixshell --on-event fish_postexec
  if test -n "$IN_NIX_SHELL"
    echo (set_color --italic cyan) "❄️ In Nix shell: " (set_color --bold red) $IN_NIX_SHELL
  end
end
