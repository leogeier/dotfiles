#!/bin/bash

git clone --bare https://github.com/leogeier/dotfiles.git $HOME/.cfg || exit $?
function dotconfig {
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
dotconfig checkout &> /dev/null
if [ $? = 0 ]; then
  echo "Checked out config."
else
  echo "Backing up pre-existing dot files to ~/.config-backup :"
  mkdir -p $HOME/.config-backup
  dotconfig checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | tee /dev/stderr | xargs -I{} mv {} .config-backup/{}
  dotconfig checkout
  echo "Checked out config."
fi;
dotconfig config status.showUntrackedFiles no
echo "All done, feel free to delete this script now."
