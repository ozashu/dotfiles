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

Package installation uses `Brewfile` on both platforms,
`Brewfile.macos` for macOS-only applications, and
`packages/ubuntu.txt` for the Ubuntu prerequisites. Homebrew must already be
installed; the setup deliberately does not execute a remote installer.

Shell settings are split into `zsh/common.zsh`, `zsh/macos.zsh`, and
`zsh/ubuntu.zsh`. Machine- or company-specific settings can be placed in
`~/.zshrc.local` and `~/.gitconfig.local`; those files are not tracked.
