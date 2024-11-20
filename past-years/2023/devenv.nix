{ pkgs, ... }:

{
  packages = [
    pkgs.go-task
  ];

  enterShell = ''
    ROCDIR="$(pwd)/$(find . -type d -iname 'roc_nightly*' | head -n 1)"
    # ROCDIR="$(pwd)/roc/target/release"
    PATH=$ROCDIR:$PATH
  '';

}
