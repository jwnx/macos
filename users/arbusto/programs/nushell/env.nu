alias nvm = fnm
alias bzl = bazelisk
alias bazel = bazelisk
alias gitl = git log --pretty=oneline --abbrev-commit --graph
alias gst = git status
alias bookmark = archivebox add

let-env PNPM_HOME = "/Users/jwnx/Library/pnpm"
# let-env PATH = '/Users/jwnx/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/Users/jwnx/.cargo/bin:/usr/local/bin:/usr/local/sbin:/etc/profiles/per-user/jwnx/bin:/run/current-system/sw/bin:/usr/bin:/usr/sbin:/bin:/sbin'

#load env variables
#load-env (fnm env --shell bash | lines | str replace "export " "" | str replace -a """ "" | split column = | rename name value | where name != "FNM_ARCH" && name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })
#load-env (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | where name != "FNM_ARCH" && name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })

let-env PATH = ($env.PATH | split row (char esep) | prepend [
    '~/.nix-profile/bin', # Nix binaries
    '/nix/var/nix/profiles/default/bin',
    '~/.cargo/bin', # Rust binaries
    '/usr/local/bin',
    '/usr/local/sbin',
    '/etc/profiles/per-user/jwnx/bin',
    '/run/current-system/sw/bin',
    '/usr/bin',
    '/usr/sbin',
    '/bin',
    '/sbin',
    '~/go/bin', # Go
    $env.PNPM_HOME,
])

let-env NIX_PATH = 'darwin-config=/Users/jwnx/.nixpkgs/darwin-configuration.nix:/nix/var/nix/profiles/per-user/root/channels:/Users/jwnx/.nix-defexpr/channels'
let-env NIX_SSL_CERT_FILE = '/etc/ssl/certs/ca-certificates.crt'
let-env NIX_USER_PROFILE_DIR = '/nix/var/nix/profiles/per-user/jwnx'
let-env NIX_PROFILES = '/nix/var/nix/profiles/default /Users/jwnx/.nix-profile'
let-env NIX_REMOTE = 'daemon'
let-env XDG_CONFIG_DIRS = '/Users/jwnx/.nix-profile/etc/xdg:/etc/profiles/per-user/jwnx/etc/xdg:/run/current-system/sw/etc/xdg:/nix/var/nix/profiles/default/etc/xdg'
let-env XDG_DATA_DIRS = '/Users/jwnx/.nix-profile/share:/etc/profiles/per-user/jwnx/share:/run/current-system/sw/share:/nix/var/nix/profiles/default/share'
let-env SSH_AUTH_SOCK = '~/.1password/agent.sock'
let-env JAVA_HOME = '/nix/store/g4vskhas8vp3xvviikyy4l594d8g2l2v-zulu17.34.19-ca-jdk-17.0.3'

# FNM
# load env variables
load-env (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | where name != "FNM_ARCH" && name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })

# add dynamic fnm path
let-env PATH = ($env.PATH | prepend $"($env.FNM_MULTISHELL_PATH)/bin")

#add dynamic fnm path
# let-env PATH = ($env.PATH | prepend "$env.FNM_MULTISHELL_PATH)/bin")

mkdir ~/.cache/starship
starship init nu | save ~/.cache/starship/init.nu

zoxide init nushell --hook prompt | save ~/.zoxide.nu