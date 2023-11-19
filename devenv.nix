{ pkgs, ... }:

{
  packages = [
    pkgs.go-task
  ];

  enterShell = ''
    ROCDIR="$(pwd)/$(find . -type d -iname 'roc_*' | head -n 1)"
    PATH=$ROCDIR:$PATH
  '';

}
