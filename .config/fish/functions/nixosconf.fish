function nixosconf --description 'Edits the current NixOS configuration, commits the changes and finally rebuilds and switches NixOS.'
  set old_dir $PWD
  cd ~/.nixos
  nvim configuration.nix
  git add configuration.nix
  git commit
  nixos-generate-config --dir .
  git add -f hardware-configuration.nix
  sudo nixos-rebuild switch --flake .#nixos
  git rm -f hardware-configuration.nix
  cd $old_dir
end
