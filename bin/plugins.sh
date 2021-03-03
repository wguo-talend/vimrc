#!/usr/bin/env bash

if [ ! -d "$HOME/.vim/pack/bundle/start" ]; then
    mkdir -p ~/.vim/pack/bundle/start
fi

cd ~/.vim/pack/bundle/start

git clone --depth 1 https://github.com/lifepillar/vim-mucomplete.git
