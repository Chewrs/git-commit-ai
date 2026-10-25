# Git commit with AI
This project uses the Google Gemini to generate commit messages.

## Installation and Usage

1. Clone this project
```
git clone https://github.com/che/git-commit-ai.git ~/git-commit-ai
cd ~/git-commit-ai
```
2. Export variables
```
export GEMINI_API_KEY="your-api-key"
export GEMINI_MODEL="gemini-3.8-flash"
```
3. add files to git
for example
```
git add .
```
4. Run the script 
```
chmod +x git-commit-ai.sh
bash git-commit-ai.sh
```

5. Set aliases on fish shell
```
function gm
    bash ~/git-commit-ai/git-commit-ai.sh
end
```

## Others

Set git editor to nvim
```
git config --global core.editor "nvim"
```
