{ pkgs, inputs, system, lib, ... }:

let
  username = "arbusto";
  fullname = "arbusto";

in

{
  imports = [
    ../modules
  ];

  my = {
    username = "${username}";

    modules = {
      dock = {
        enable = false;

        entries = [
          { path = "/System/Applications/Launchpad.app"; }
          { path = "/Applications/iTerm.app"; }
          { path = "/System/Applications/Mail.app"; }
          {
            path = "/Users/${username}/Downloads/";
            section = "others";
            options = "--sort dateadded --view grid --display folder";
          }
        ];
      };
    };
  };

  users = {
    users = {
      "${username}" = {
        description = "${fullname}";
        shell = pkgs.nushell;
        home = "/Users/${username}";
      };
    };
  };

  home-manager.users."${username}" = { config, ... }: {
    home = {
      homeDirectory = "/Users/${username}";

      sessionPath = [
        "$HOME/.local/bin"
      ];

      stateVersion = "22.05";

      packages = with pkgs; [
        # AWS
        awscli2

        git

        # QoL
        nixpkgs-fmt
        vale
        # A wrapper that provides access to the Mac OS X pasteboard service
        reattach-to-user-namespace
        # archivebox # https://archivebox.org/
        # shellcheck
        # hyperfine

        # node pkgs
        nodejs-16_x
        fnm # node version manager
        nodePackages.pnpm
        nodePackages.typescript
        nodePackages.typescript-language-server
        nodePackages.yarn

        # bazel pkgs
        bazel-buildtools
        bazelisk

        # extra language servers
        # solargraph
        # rnix-lsp
        rust-analyzer

        # debugging
        # delve # golang

        # tools
        # exercism
      ];
    };

    programs = {
      home-manager.enable = true;
      zoxide.enable = true;

      exa = {
        enable = true;
        enableAliases = true;
      };

      bat = {
        enable = true;
        config = {
          theme = "TwoDark";
          pager = "less -FR";
          map-syntax = [ "*.jenkinsfile:Groovy" "*.props:Java Properties" ];
        };
      };

      gh = {
        enable = true;
        settings = {
          editor = "nvim";
          git_protocol = "ssh";
        };
      };

      java = {
        enable = true;
      };

      # alacritty = import ./programs/alacritty.nix { inherit pkgs; };
      # direnv = import ./programs/direnv.nix { inherit pkgs; };
      # fzf = import ./programs/fzf.nix { inherit pkgs; };
      neovim = import ./programs/neovim.nix { inherit pkgs lib; };
      # readline = import ./programs/readline.nix { inherit pkgs; };
      # ssh = import ./programs/ssh.nix { inherit pkgs; };
      # fish = import ./programs/fish.nix { inherit pkgs lib; };
      nushell = import ./programs/nushell.nix { inherit pkgs lib; };
      # archivebox = import ./programs/archivebox.nix { inherit pkgs lib python3; };
      starship = import ./programs/starship.nix { inherit pkgs; };
      tmux = import ./programs/tmux.nix { inherit pkgs; };
      zsh = import ./programs/zsh.nix { inherit pkgs; };
    };
  };
}
