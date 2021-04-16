#!/usr/bin/env bash

mkdir $IPYTHONDIR
ipython profile create
unalias cp
cp -r $DOTDEVDIR/ipython_config.json $IPYTHONDIR/profile_default

for dir in $BASEDIR/*; do
    if [ -f "${dir}/setup.py" ]; then
        pip install -e "$dir"
        echo "${dir} setup"
    fi
done

# from https://github.com/microsoft/vscode-dev-containers/blob/master/container-templates/docker-compose/.devcontainer/library-scripts/common-debian.sh
# Codespaces bash and OMZ themes - partly inspired by https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/robbyrussell.zsh-theme
CODESPACES_BASH="$(cat \
<<'EOF'
# Enable tab completion
source ~/git-completion.bash

# colors!
green="\[\033[0;32m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
reset="\[\033[0m\]"

# Change command prompt
source ~/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$purple\u$green\$(__git_ps1)$blue \W $ $reset"
###
EOF
)"

echo "${CODESPACES_BASH}" >> "/root/.bashrc"