{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.apps;
in

{
  options = with lib; {
    my = {
      modules = {
        apps = {
          enable = mkEnableOption ''
            Whether to enable apps module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      environment = {
        systemPackages = with pkgs; [
        #   ngrok
        ];
      };

      homebrew = {
        casks = [
          "alfred"
          "appcleaner" # delete applications
          "chromium"
          "docker"

          "dozer" # hide menubar icons

          "figma" # ui

          "iina"
          "iterm2" # terminal

          "karabiner-elements" # keyboard modifications
          "obsidian" # Note-taking tool

          "nordvpn" # vpn
          "swish" # window controls


          "tailscale" # internal network
          "telegram" # messaging
          "transmission" # torrents
          "discord"
          "whatsapp"
          "zoom" # for video conferencing
        ];
      };
    };
}