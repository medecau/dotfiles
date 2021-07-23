# Witch Hazel Hypercolor ZSH Theme
#
# https://witchhazel.thea.codes/
# https://twitter.com/ZoeIsNowOoze/status/1418271734327820289
#
# 1. Download this theme:
#
#     `wget -O ~/.oh-my-zsh/custom/themes/witchhazelhypercolor.zsh-theme \
#      https://gist.githubusercontent.com/medecau/8174b85406a3b9fd293661ec329c10f7/raw/witchhazelhypercolor.zsh-theme`
#
#
# 2. Set the name of the theme to load in the ~/.zshrc configuration:
#
#     sed -i '' 's/ZSH_THEME.*/ZSH_THEME=witchhazelhypercolor/' .zshrc
#

local ret_status="%(?:%{$FG[121]%}❯ :%{$FG[218]%}❯ )"
PROMPT='${ret_status} %{$bold_color%}%{$FG[123]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$bold_color%}%{$FG[183]%}git:(%{$reset_color%}%{$FG[218]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$bold_color%}%{$FG[183]%}) %{$FG[228]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$bold_color%}%{$FG[183]%})"
