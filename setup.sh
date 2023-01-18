#!/bin/bash
# Setup script. Used to set up a new machine, or simply ensure an existing machine has the prerequisites for development.
# Run using: /bin/bash -c "$(curl -fsSl https://raw.githubusercontent.com/JonasPhilbert/dotfiles/master/setup.sh)"

# Start at $HOME
cd

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install git
brew install git

# Clone dotfiles repo to home dir
git clone https://github.com/JonasPhilbert/dotfiles.git .

brew install fish
brew install fisher
brew install neovim
brew install tmux
brew install ripgrep
brew install fzf
