# dotfiles

macOS and Ubuntu share the main configuration while loading
platform-specific settings where required.

## Setup

Create the configuration links without installing packages:

```sh
./setup.sh
```

Install packages as well:

```sh
./setup.sh --packages
```

On macOS, package installation uses `Brewfile` and `Brewfile.macos`, and
Homebrew must already be installed. On Ubuntu, packages are installed with
`apt-get` from `packages/ubuntu.txt`; Homebrew is not required. Tools in the
Brewfiles that are unavailable from the Ubuntu package repositories are not
installed on Ubuntu.

Shell settings are split into `zsh/common.zsh`, `zsh/macos.zsh`, and
`zsh/ubuntu.zsh`. Machine- or company-specific settings can be placed in
`~/.zshrc.local` and `~/.gitconfig.local`; those files are not tracked.
