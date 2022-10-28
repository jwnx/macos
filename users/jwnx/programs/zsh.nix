{ pkgs, ... }:

{
    enable = true;

    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    history = {
        ignoreDups = true;
        ignoreSpace = true;
        expireDuplicatesFirst = true;
    };

    shellAliases = {
        reload = "source ~/.zshrc";
        cp = "cp -i";
        mv = "mv -i";
        rm = "rm -i";
        ack = "ag";
        bazel = "bazelisk";
        cdk = "$(yarn bin)/cdk";
        gitl = "git log --pretty=oneline --abbrev-commit --graph";
    };

    localVariables = {
        EDITOR = "nvim";
        SSH_AUTH_SOCK = "~/.1password/agent.sock";
        ZSH_DISABLE_COMPFIX = "true";
        LC_ALL = "pt_BR.UTF-8";
    };

    oh-my-zsh = {
        enable = true;
        plugins = ["gpg-agent" "sudo" "git" "gh"];
    };

    plugins = [
        {
            name = "zsh-syntax-highlighting";
            src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.7.1";
            sha256 = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
            };
        }
        {
            # will source zsh-autosuggestions.plugin.zsh
            name = "zsh-autosuggestions";
            src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
            };
        }
        {
            name = "zsh-completions";
            src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-completions";
            rev = "0.33.0";
            sha256 = "sha256-cQSKjQhhOm3Rvnx9V6LAmtuPp/ht/O0IimpunoQlQW8=";
            };
        }
    ];
}