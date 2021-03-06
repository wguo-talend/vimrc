#!/usr/bin/env bash

if [ ! -d "$HOME/.vim/pack/bundle/start" ]; then
    mkdir -p ~/.vim/pack/bundle/start
fi

cd ~/.vim/pack/bundle/start

git_plugins=( "tpope/vim-sensible" "lifepillar/vim-mucomplete" "tpope/vim-fugitive" "tpope/vim-commentary" "tpope/vim-surround" "tpope/vim-vinegar" "tpope/vim-sleuth" "tpope/vim-obsession" "raimondi/delimitmate" "ctrlpvim/ctrlp.vim" )

linter_plugins=( "dense-analysis/ale" )

for plugin in "${git_plugins[@]}"; do
    folder=$(echo $plugin | cut -d'/' -f2)
    if [ ! -d "$folder" ]; then
        git clone --depth 1 "https://github.com/$plugin.git"
    else
        cd "$folder"
        git fetch origin
        cd ..
    fi
done

for plugin in "${linter_plugins[@]}"; do
    folder=$(echo $plugin | cut -d'/' -f2)
    if [ ! -d "$folder" ]; then
        git clone --depth 1 "https://github.com/$plugin.git"
    else
        cd "$folder"
        git fetch origin
        cd ..
    fi
done
