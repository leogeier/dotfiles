#!/bin/bash

git clone --bare https://github.com/leogeier/dotfiles.git $HOME/.cfg
function dotconfig {
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
dotconfig checkout &> /dev/null
if [ $? = 0 ]; then
  echo "Checked out config.";
else
  echo "Backing up pre-existing dot files.";
  mkdir -p $HOME/.config-backup
  dotconfig checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
dotconfig checkout
dotconfig config status.showUntrackedFiles no
