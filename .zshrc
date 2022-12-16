# Bash cheat sheet: https://devhints.io/bash
# Difference between single and double square brackets in if-statements: http://mywiki.wooledge.org/BashFAQ/031

LOADED=()

#########################################
# Zsh (oh my zsh) Setup & Configuration #
#########################################

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

plugins=(git ruby rails bundler heroku docker zsh-autosuggestions)

# ohmyzsh theme. See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"

# Show command completion dots.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

# https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"

##################
# External Setup #
##################

# Import any secrets envvars if defined in ~/.secrets.
[[ -s "$HOME/.secrets" ]] && source $HOME/.secrets && LOADED+=("secrets")

# Preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Linuxbrew shell-env if on Linux.
[[ -s "/home/linuxbrew/.linuxbrew/bin/brew" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && LOADED+=("linuxbrew")

# Homebrew shell-env if on MacOS.
[[ -s "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)" && LOADED+=("macbrew")

# Recommended by Homebrew.
[[ -n $(command -v rbenv) ]] && eval "$(rbenv init --no-rehash - zsh)" && LOADED+=("rbenv")

# Recommended by Homebrew.
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh" && LOADED+=("nvm")

echo -n "Loaded: "
for i in "${LOADED[@]}"; do
  echo -n "$i "
done
echo

############
# Commands #
############

# Create tnt dir for tnt (trash) alias.
[[ ! -d $HOME/.tnt ]] && mkdir $HOME/.tnt && echo "Trash directory (~/.tnt) created."

# Trashing command.
function trash() {
  NAME="$1.$(date +"%Y-%m-%d-%H%M%S")"
  mv $1 $NAME
  mv $NAME ~/.tnt
}

# Postmaster command.
# When retarting, postgres sometimes won't delete the .pid file and complain when booting again. I always forget how to fix it, so now this:
function postmaster-fix() {
  if [[ $(tail -1 /opt/homebrew/var/log/postgresql* | grep postmaster.pid) ]]; then
    trash /opt/homebrew/var/postgres/postmaster.pid
    echo "Postmaster.pid trashed. Restarting postgres."
    brew services restart postgresql
  else
    echo "No postmaster.pid error found in postgres log."
  fi
}

###########
# Aliases #
###########

# Aliases - Personal
alias tmuxdev="tmux split-window -h && tmux split-window && tmux resize-pane -R 30 && tmux select-pane -L && tmux rename-window DEVELOPMENT"
alias tmuxops="tmux split-window -h && tmux split-window && tmux select-pane -L && tmux rename-window OPS"
alias islands="cd ~/git/islands"
alias servers="lsof -iTCP -sTCP:LISTEN -n -P"
alias notes="$EDITOR ~/NOTES.md"
alias rm="echo You should probably use 'trash' instead. To override, use full bin path: '/bin/rm'."
alias rawsomnia="cd ~/.config/insomnia && git pull && INSOMNIA_DATA_PATH=~/.config/insomnia /Applications/Insomnia.app/Contents/MacOS/Insomnia && git commit -am :robot: && git push"
alias insomnia="tmux new-session -s insomnia -d 'cd ~/.config/insomnia && git pull && INSOMNIA_DATA_PATH=~/.config/insomnia /Applications/Insomnia.app/Contents/MacOS/Insomnia && git commit -am :robot: && git push'" # Create detached tmux session, run insomnia inside it, then push changes.

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
alias rfail="rspec --only-failures"

# Aliases - Scripts
alias pr="~/scripts/pr.rb"
