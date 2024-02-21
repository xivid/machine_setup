#!/bin/bash

backup_old_config () {
	if [ -e $1 ]; then
		mkdir -p ~/.oks_old_config
		cp -r $1 ~/.oks_old_config
		echo "Old " $1 " found, copied into " $(realpath ~/.oks_old_config)
	fi
}

echo "One-key Development Environment Setup"

echo "Setting up tmux config"
backup_old_config ~/.tmux.conf
cp .tmux.conf ~/

echo "Setting up fzf"
if [ -e ~/.fzf ] then
	echo "fzf seems to be already existing, skipped"
else
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
fi

echo "Setting up vim config"
backup_old_config ~/.vimrc
backup_old_config ~/.vim
cp .vimrc ~/
if grep -Fq "undodir" .vim then
	mkdir -p ~/.vim/undo-dir
fi
vim +'PlugInstall --sync' +qa

echo "============="
echo "All Completed"
echo "============="
