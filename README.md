# dotfiles

.files for my own personal use.

## Starting from a fresh machine

### Linux (NixOS)

1. Install NixOS on a machine or VM.
1. Create an SSH key for GitHub using: `ssh-keygen -t ed25519`, and add it to the SSH agent using: `ssh-add ~/.ssh/id_ed25519`
1. Upload the public SSH key to GitHub (you may need to do: `eval `ssh-agent -s`` to set up env for ssh-add)
1. Clone the repo to a temp. folder using: `git clone git@github.com:JonasPhilbert/dotfiles.git ~/dotfiles`
1. Copy repo contents to home using: `cp ~/dotfiles/. ~ -rf`
1. Delete temporary folder using: `rm -rf ~/dotfiles`
1. Copy NixOS hardware configuration to main NixOS flake folder using: `sudo cp /etc/nixos/hardware-configuration.nix ~/.nixos`
1. Rebuild NixOS using the cloned flake using: `sudo nixos-rebuild switch --flake ~/.nixos#nixos`
1. Profit! :tada:

### MacOS

`TODO`
