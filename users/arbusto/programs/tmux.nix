{ pkgs, ... }:

let
  tmux-nova = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "nova";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "o0th";
      repo = "tmux-nova";
      rev = "3e56f80a12b284cd33ab25d58671799e983dc70c";
      sha256 = "sha256-xT4V6ot1o9A8hNKr3mAr7pgl9FYlFxcionR3vIYAfzY=";
    };
  };

  # pkgs = import (builtins.fetchGit {
  #   name = "tmux-3.0a";
  #   url = "https://github.com/nixos/nixpkgs-channels/";
  #   ref = "refs/heads/nixpkgs-20.03-darwin";
  #   rev = "690441cccc723346c568e2ecac985140ae062d86";
  # }) {};

  # tmux = pkgs.tmux;
in
{
  enable = true;
  shortcut = "a";
  newSession = false;
  clock24 = true;
  sensibleOnTop = true;
  baseIndex = 1;
  keyMode = "vi";
  historyLimit = 100000;
  terminal = "screen-256color";

  extraConfig = ''
    set -g mouse on

    # Allow us to reload our Tmux configuration while using Tmux
    #bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

    # Allow Sync between all open panes
    bind s set-window-option synchronize-panes

    # Copy to clipboard
    if -b 'command -v pbcopy > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | pbcopy"'
    if -b 'command -v reattach-to-user-namespace > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | reattach-to-user-namespace pbcopy"'

    bind | split-window -h
    bind - split-window -v
    bind-key R refresh-client

    set -g set-clipboard on
    set -g mouse on
  '';

  plugins = with pkgs.tmuxPlugins; [
    yank
    vim-tmux-navigator
    pain-control
    prefix-highlight
    open
    onedark-theme

    # {
    #   plugin = onedark-theme;
    #   extraConfig = ''
    #     set -g @plugin 'odedlaz/tmux-onedark-theme'
    #   '';
    # }
    # {
    #   plugin = tmux-nova;
    #   extraConfig = ''
    #     set -g @plugin 'o0th/tmux-nova'

    #     set -g @nova-nerdfonts false
    #     set -g @nova-nerdfonts-left ""
    #     set -g @nova-nerdfonts-right ""

    #     set -g @nova-segment-mode "#S"
    #     set -g @nova-segment-mode-colors "#50fa7b #282a36"

    #     set -g @nova-segment-whoami "#h"
    #     set -g @nova-segment-whoami-colors "#50fa7b #282a36"

    #     set -g @nova-pane "#I#{?pane_in_mode,  #{pane_mode},}"

    #     set -g @nova-rows 0
    #     set -g @nova-segments-0-left "mode"
    #     set -g @nova-segments-0-right "whoami "
    #   '';
    # }
  ];
}