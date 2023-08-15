# load files from ~/.zshrc.d

for file in ~/.zshrc.d/*.zsh; do
  source $file
done
