# Environment

if test -e ~/.secrets
  source ~/.secrets
end

set -gx EDITOR nvim

eval (/opt/homebrew/bin/brew shellenv)

# Aliases - Personal

alias rc="$EDITOR ~/.config/fish/config.fish"
alias tmuxdev="tmux split-window -h && tmux split-window && tmux resize-pane -R 30 && tmux select-pane -L && tmux rename-window DEVELOPMENT"
alias tmuxops="tmux split-window -h && tmux select-pane -L && tmux rename-window OPS"

# Aliases - Work

alias fl="cd ~/git/flightlogger"
alias work="bin/rake jobs:work"
alias workoff="bin/rake jobs:workoff"
alias workclear="bin/rake jobs:clear"
alias by="nvm use && bundle install & yarn"
alias bym="by & bin/rails db:migrate RAILS_ENV=development"
alias bymc="bym && git restore db/schema.rb"
alias pbymc="git pull && bymc"

# if status is-interactive
#     # Commands to run in interactive sessions can go here
# end
