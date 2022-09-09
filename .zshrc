# Difference between single and double square brackets in if-statements: http://mywiki.wooledge.org/BashFAQ/031

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Import any secrets envvars if defined in ~/.secrets.
if [ -f "$HOME/.secrets" ]; then
  source $HOME/.secrets
fi

# ohmyzsh theme. See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"

# Show command completion dots.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

plugins=(git ruby rails bundler heroku docker zsh-autosuggestions)
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"

source $ZSH/oh-my-zsh.sh

# User Configuration

# Linuxbrew shell-env if on Linux.
if  [[ -x "$(command -v /home/linuxbrew/.linuxbrew/bin/brew)" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Homebrew shell-env if on MacOS.
if [[ -x "$(command -v /opt/homebrew/bin/brew)" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Recommended by Homebrew.
if [[ -x "$(command -v rbenv)" ]]; then
  eval "$(rbenv init - --no-rehash)"
fi

# Recommended by Homebrew.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Aliases - Personal
alias tmuxdev="tmux split-window -h && tmux split-window && tmux resize-pane -R 30 && tmux select-pane -L && tmux rename-window DEVELOPMENT"
alias tmuxops="tmux split-window -h && tmux split-window && tmux select-pane -L && tmux rename-window OPS"
alias islands="cd ~/git/islands"
alias servers="lsof -iTCP -sTCP:LISTEN -n -P"

# Aliases - Work
alias fl="cd ~/git/flightlogger"
alias work="bin/rake jobs:work"
alias workoff="bin/rake jobs:workoff"
alias workclear="bin/rake jobs:clear"
alias by="bundle install & yarn"
alias bym="by & bin/rails db:migrate RAILS_ENV=development"
alias bymc="bym && git restore db/schema.rb"
alias pbymc="git pull && bymc"
alias tsc="node_modules/typescript/bin/tsc"
alias cloudman="foreman start -c worker_cloudsync=3"
alias prw="gh pr view --web"

# Aliases - Scripts
alias pr="~/scripts/pr.rb"
