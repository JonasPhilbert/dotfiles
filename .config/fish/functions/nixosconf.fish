function nixosconf --description 'Edits the current NixOS configuration, rebuilds and switches NixOS and, if successful, commits the changes.'
  set old_dir $PWD
  cd ~/.nixos
  nvim configuration.nix
  if test -n "$(git diff -- configuration.nix)";
    git add configuration.nix
    nixosbuild
    set success $status
    if test $success -eq 0;
      git commit
    else
      echo (set_color "red")"NixOS build failed."
    end
  else;
    echo (set_color "magenta")"No changes to configuration.nix detected. Aborting."
  end
  cd $old_dir
end
