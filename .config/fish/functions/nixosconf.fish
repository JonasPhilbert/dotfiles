function nixosconf --description 'Edits the current NixOS configuration, commits the changes and finally rebuilds and switches NixOS.'
  set old_dir $PWD
  cd ~/.nixos
  nvim configuration.nix
  if test -n "$(git diff -- configuration.nix)";
    git add configuration.nix
    nixos-generate-config --dir .
    git add -f hardware-configuration.nix
    sudo nixos-rebuild switch --flake .#nixos
    set success $status
    git rm -f hardware-configuration.nix
    if test $success -eq 0;
      git commit
    end
  else;
    echo "No changes to configuration.nix detected. Aborting."
  end
  cd $old_dir
end
