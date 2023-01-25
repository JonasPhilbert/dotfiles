# Initialize rbenv
status --is-interactive; and rbenv init - fish | source

# Aliases
alias fl="cd ~/git/flightlogger && nvm install -s"
alias rspec="bundle exec rspec"
alias rake="bundle exec rake"
alias prw="gh pr view --web"
alias insomnia="tmux new-session -s insomnia -d 'cd ~/.config/insomnia && git pull && INSOMNIA_DATA_PATH=~/.config/insomnia /Applications/Insomnia.app/Contents/MacOS/Insomnia && git commit -am :robot: && git push'" # Create detached tmux session, run insomnia inside it, then push changes.
alias work="bin/rake jobs:work"
alias workoff="bin/rake jobs:workoff"
alias workclear="bin/rake jobs:clear"
alias by="nvm install && bundle install & yarn"
alias bym="by & bin/rails db:migrate RAILS_ENV=development"
alias bymc="bym && git restore db/schema.rb"
alias pbymc="git pull && bymc"
