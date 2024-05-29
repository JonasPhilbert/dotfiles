function nixosbuild --description 'Rebuilds and switches NixOS.'
  set old_dir $PWD
  cd ~/.nixos
  nixos-generate-config --dir . # Generate hardware configuration to PWD.
  git add -f hardware-configuration.nix # Nix will not consider files not added to git in the build, so even though we don't wish to commit the hardware config, we must add it here for the build.
  sudo nixos-rebuild switch --flake .#nixos # The actual build.
  set success $status
  git rm -f hardware-configuration.nix # Remove hardware config from git. We don't actually want to commit it.
  cd $old_dir
  return $success
end
