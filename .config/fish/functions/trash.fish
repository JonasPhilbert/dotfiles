function trash
  set name $argv[1]"."(date +"%Y-%m-%d-%H%M%S")
  mv $argv[1] $name
  mv $name ~/.tnt
end
