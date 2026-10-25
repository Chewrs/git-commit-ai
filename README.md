# Git Commit AI

Generate concise [Conventional Commit](https://www.conventionalcommits.org/) messages from staged Git changes using Google Gemini. The generated message opens in your Git editor for review before the commit is created.

## Requirements

- Bash
- Git
- `curl`
- `jq`
- A [Gemini API key](https://aistudio.google.com/apps)

## Setup

```sh
git clone https://github.com/che/git-commit-ai.git ~/git-commit-ai
cd ~/git-commit-ai
chmod +x git-commit-ai.sh
```

Set your Gemini API key. `GEMINI_MODEL` is optional and defaults to `gemini-3.8-flash`.

```sh
export GEMINI_API_KEY="your-api-key"
export GEMINI_MODEL="gemini-3.8-flash"
```

See the [Gemini API documentation](https://aistudio.google.com/docs?codelanguage=rest) for API details.

## Usage

Stage your changes, then run the script:

```sh
git add .
bash ~/git-commit-ai/git-commit-ai.sh
```

Review and edit the generated message in your Git editor, then save and close the editor to create the commit.

### shell alias

#### Fish
Add this function to `~/.config/fish/config.fish`:

```fish
function gm
    bash ~/git-commit-ai/git-commit-ai.sh
end
```
Reload the fish shell:

```
source ~/.config/fish/config.fish
```
#### Bash or Zsh alias

Add this alias to `~/.bashrc` (Bash) or `~/.zshrc` (Zsh):

```bash
alias gm='bash ~/git-commit-ai/git-commit-ai.sh'
```

Reload your shell configuration:

**Bash:**
```bash
source ~/.bashrc
```

**Zsh:**
```bash
source ~/.zshrc
```

Now run `gm` from any directory to execute the script.

## Optional: Set Neovim as the Git editor

```sh
git config --global core.editor "nvim"
```
