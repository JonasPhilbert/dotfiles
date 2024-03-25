function nixosconf --description 'Rebuilds and switches NixOS.'
  set old_dir $PWD
  cd ~/.nixos
  nixos-generate-config --dir .
  git add -f hardware-configuration.nix
  sudo nixos-rebuild switch --flake .#nixos
  git rm -f hardware-configuration.nix
  cd $old_dir
end
