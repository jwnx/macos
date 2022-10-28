{ pkgs, lib, ... }:

{
    enable = true;

    configFile.text = ''
    source ~/.cache/starship/init.nu
    source ~/.zoxide.nu
    '';

    envFile.text = ''
        ${lib.strings.fileContents ./nushell/env.nu}
    '';
}