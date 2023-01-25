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

# Install homebrew packages
brew install fish
brew install fisher
brew install neovim
brew install tmux
brew install ripgrep
brew install fzf

# Install homebrew casks
brew install --cask alacritty

# Install latest node version
fish -c "nvm install latest"

clear

echo 'Setup complete. Further steps to consider:'
echo '  1) Set default shell to fish using chsh.'
echo '  2) Start nvim and run :PackerSync to install packages and initialize.'
echo '  3) Move/copy .secrets from another machine.'
echo '  4) Download and install other environment-specific packages.'

exec fish
