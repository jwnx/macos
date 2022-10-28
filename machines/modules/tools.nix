{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.tools;
in

{
  options = with lib; {
    my = {
      modules = {
        tools = {
          enable = mkEnableOption ''
            Whether to enable tools module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      environment = {
        systemPackages = with pkgs; [
          git
          gnumake
          htop
          jq
          go
          nmap
          tmux
          tree
          neovim
          wget
          yq
          coreutils
          silver-searcher
        ];
      };
    };
}