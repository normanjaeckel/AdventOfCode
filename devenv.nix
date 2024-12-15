{ pkgs, lib, config, inputs, ... }:

{
  # See full reference at https://devenv.sh/reference/options/

  packages = [ pkgs.git ];

  enterShell = ''
    PATH=roc-dir:$PATH
  '';

  scripts = {
    roc-format.exec = "roc format day$1.roc";
    roc-check.exec = "roc check day$1.roc";
    roc-test.exec = "roc test day$1.roc";
    roc-ci.exec = "roc-format $1 && roc-check $1 && echo '.' && roc-test $1";
  };
}
