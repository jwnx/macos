{ pkgs, lib, config, options, ... }:

let
  cfg = config.my.modules.git;

in

{
  options = with lib; {
    my = {
      modules = {
        git = {
          enable = mkEnableOption ''
            Whether to enable git module
          '';
        };
      };
    };
  };

  config = with lib;
    mkIf cfg.enable {
      home-manager.users."${config.my.username}" = { config, ... }: {
        programs = {
          git = {
            enable = true;

            userName = "Juliana Oliveira";
            userEmail = "juliana@uma.ni";

            aliases = {
              s = "status";
              co = "checkout";
              d = "diff --color-moved";
              ci = "commit";
              ca = "commit -a -s";
              b = "branch -vv";
              sh = "show --color-moved";
              l = "log --graph --color --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
            };


            ignores = [
              ".DS_Store"
              ".direnv"
            ];

            extraConfig = {
              init = {
                defaultBranch = "main";
              };

              core = {
                editor = "nvim";
                excludesfile = "~/.gitignore";
                quotepath = false;
              };

              push = {
                default = "matching";
                followTags = true;
              };

              pull = {
                release = true;
              };

              format = {
                signoff = true;
              };

              color = {
                ui = "auto";
                filemode = true;
                logallrefupdates = true;
                whitespace = "space-before-tab, trailing-space";

                diff = {
                  meta = 11;
                  frag = "magenta bold";
                  old = "red bold";
                  new = "green bold";
                  commit = "yellow bold";
                  whitespace = "red reverse";
                };

                diff-highlight = {
                  oldNormal = "red bold";
                  oldHighlight = "red bold 52";
                  newNormal = "green bold";
                  newHighlight = "green bold 52";
                };

                branch = {
                  current = "yellow reverse";
                  local = "yellow bold";
                  remote = "green bold";
                  plain = "red bold";
                };

                status = {
                  added = "yellow";
                  changed = "green bold";
                  untracked = "blue bold";
                };
              };
            };

            delta = {
              enable = true;
              options = {
                features = "line-numbers,decorations,dracula";
                line-numbers = true;
                minus-color = "#572a43";
                minus-emph-color = "#E55D71";
                plus-color = "#2A4A50";
                plus-emph-color = "#4B8F8C";
                syntax-theme = "Dracula";
                whitespace-error-style = "22 reverse";
                decorations = {
                  commit-decoration-style = "bold yellow box ul";
                  file-style = "bold yellow ul";
                  file-decoration-style = "none";
                };
              };
            };
          };
        };
      };
    };
}