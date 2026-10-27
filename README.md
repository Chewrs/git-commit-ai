# Git Commit AI

Generate concise [Conventional Commit](https://www.conventionalcommits.org/) messages from staged changes with Google Gemini. Review or edit each message in your Git editor before committing.

## Requirements

- Bash
- Git
- curl
- jq
- A [Gemini API key](https://aistudio.google.com/api-keys)

## Installation

```sh
git clone https://github.com/che/git-commit-ai.git ~/git-commit-ai
cd ~/git-commit-ai
chmod +x git-commit-ai.sh
```

Set your API key:

```sh
export GEMINI_API_KEY="your-api-key"
```


The script uses `gemini-3.1-flash-lite` by default. Set `GEMINI_MODEL` to use another model:

```sh
export GEMINI_MODEL="model-name"
```

## Usage

Stage your changes and run:

```sh
git add .
~/git-commit-ai/git-commit-ai.sh
```

Save and close the editor to create the commit.

## Aliases

For Bash or Zsh, add this to `~/.bashrc` or `~/.zshrc`:

```sh
alias gm='~/git-commit-ai/git-commit-ai.sh'
```

For Fish, add this to `~/.config/fish/config.fish`:

```fish
alias gm '~/git-commit-ai/git-commit-ai.sh'
```

Reload the shell configuration, then run `gm` from any Git repository.

## Optional: Raspberry Pi dependencies

On Raspberry Pi OS, install `curl` and `jq` if they are not already installed:

```sh
sudo apt update
sudo apt install curl jq
```

## Optional: Git editor

```sh
git config --global core.editor "nvim"
```

## Optional: Set a permanent Gemini API key

add this to `~/.bashrc` or `~/.zshrc` or `~/.config/fish/config.fish`:

```sh
export GEMINI_API_KEY="your-api-key"
```
